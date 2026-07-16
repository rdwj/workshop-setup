# Scaling Control Plane Nodes on OpenShift 4 (AWS)

This guide walks through scaling a single-master OpenShift 4.18 cluster on AWS to a three-node control plane. It is written for cluster administrators learning OpenShift on RHPDS sandbox environments, though the concepts apply to any OCP 4.14+ cluster on AWS.

## Background

A production OpenShift cluster runs three control plane nodes to achieve high availability through etcd quorum. RHPDS sandbox clusters sometimes start with a single master, which is convenient for resource usage but is a single point of failure. Scaling to three masters gives you the ability to lose one node without losing the cluster.

One important note on intermediate states: **do not stop at two masters**. With two control plane nodes, etcd requires both to be healthy to maintain quorum (majority of 2 is 2). This is actually worse than a single master — you now have two nodes that can each independently kill your cluster. Go from one directly to three.

## The ControlPlaneMachineSet Catch-22

OpenShift 4.14 introduced the ControlPlaneMachineSet (CPMS) operator, which manages control plane machine lifecycle similarly to how MachineSets manage workers. On a healthy three-master cluster, CPMS is the right tool. For our scaling task, however, it creates a chicken-and-egg problem.

The CPMS admission webhook enforces two constraints simultaneously:

1. `spec.replicas` must match the current number of control plane Machine objects.
2. `spec.replicas` only accepts values of 3 or 5.

If you have one master and try to set `replicas: 3`, the webhook rejects it because 3 doesn't match the current count of 1. If you try `replicas: 1`, the webhook rejects it because 1 is not a supported value. There is no path forward through CPMS alone.

The solution is to create the two additional Machine objects manually, wait for all three masters to reach `Running` state, and only then apply the CPMS. Once three Machine objects exist, `replicas: 3` satisfies both constraints and the webhook accepts it.

## Step 1: Extract the providerSpec from Your Existing Master

Every Machine object on AWS carries a `providerSpec` that describes how the cloud provider should create the instance. The new masters must use a providerSpec that closely mirrors the existing master — several fields are non-negotiable.

Start by inspecting your existing master:

```bash
oc get machines -n openshift-machine-api -l machine.openshift.io/cluster-api-machine-role=master
```

Then export the full YAML:

```bash
oc get machine <master-name> -n openshift-machine-api -o yaml
```

The following fields must be carried over exactly:

**`ami`** — The RHCOS image ID. This is region-specific and tied to the OpenShift version. Using a different AMI will result in a node that cannot join the cluster.

**`instanceType`** — Must match your other masters. Mixed instance types in a control plane are unsupported.

**`iamInstanceProfile`** — Grants the instance the AWS API permissions it needs. The profile name follows the pattern `<infra-name>-master-profile`.

**`loadBalancers`** — This is the most commonly missed field. You must include references to **both** the internal and external API load balancers. Without them, the AWS load balancers will not route traffic to the new nodes, and the API will be unreachable from those nodes' perspective.

**`securityGroups`** — Three groups are required: the node security group, the load balancer security group, and the control plane security group. Missing any one of them will cause connectivity or etcd membership issues.

**`userDataSecret`** — Must be `master-user-data`. Do not use `worker-user-data`. This secret contains the ignition configuration that bootstraps the node as a control plane member.

**`tags`** — Must include the cluster-specific AWS tags. These tags are how OpenShift's cloud provider code identifies resources, and they're how AWS cleanup works on teardown. Missing tags will cause problems when the sandbox expires.

**`subnet`, `placement`, `credentialsSecret`** — Copy these verbatim from the existing master.

## Step 2: Write the Machine YAML for Each New Master

Create one YAML file per new master. The files in this directory (`master-1.yaml` and `master-2.yaml`) are already filled in for the cluster used in this workshop. If you are adapting this for a different cluster, the key things to change are:

- `metadata.name`: Follow the convention `<infra-name>-master-N`. Your infra name can be found in the existing master's name or in the cluster's infrastructure object (`oc get infrastructure cluster -o jsonpath='{.status.infrastructureName}'`).
- The `placement.availabilityZone` and `subnet` values, if you want to spread masters across AZs (recommended for production, optional for sandboxes).

The `metadata.labels` block must include:

```yaml
labels:
  machine.openshift.io/cluster-api-cluster: <infra-name>
  machine.openshift.io/cluster-api-machine-role: master
  machine.openshift.io/cluster-api-machine-type: master
```

Everything else in `spec.providerSpec` should be copied from the existing master.

## Step 3: Apply the Machine Objects

```bash
oc apply -f master-1.yaml -f master-2.yaml
```

Confirm the machines were created:

```bash
oc get machines -n openshift-machine-api -l machine.openshift.io/cluster-api-machine-role=master
```

You should now see three Machine objects. The new ones will initially show an empty or `Provisioning` phase.

## Step 4: Wait for Convergence

This process takes roughly 10–15 minutes. The sequence of events is:

1. The Machine API controller picks up the new Machine objects and requests EC2 instances from AWS. The machines enter `Provisioning` phase.
2. EC2 instances start. RHCOS boots and fetches its ignition configuration from the `master-user-data` secret. The machines move to `Provisioned` phase.
3. The Kubernetes node registers with the API server. Phase becomes `Running`, but node status is `NotReady`.
4. Node initialization completes — CNI, kubelet configuration, CSRs approved. Node status becomes `Ready` with roles `control-plane,master,worker`.
5. The etcd operator detects the new control plane nodes and begins adding them as etcd members. During this phase you will see etcd pods in `CrashLoopBackOff` and members reported as unhealthy. **This is normal and expected.** The etcd operator is rolling new revisions to each member, and the cluster will self-heal.
6. All three etcd members are healthy and in sync.

Monitor progress with:

```bash
# Watch machine phase transitions
oc get machines -n openshift-machine-api -l machine.openshift.io/cluster-api-machine-role=master -w

# Watch node readiness
oc get nodes -w

# Check etcd member status
oc get etcd cluster -o jsonpath='{.status.conditions[?(@.type=="EtcdMembersAvailable")].message}'
```

If a machine gets stuck in `Provisioning` for more than five minutes, inspect the machine object for error conditions:

```bash
oc describe machine <machine-name> -n openshift-machine-api
```

RHPDS sandbox accounts have AWS instance quotas. If the quota for `m6a.2xlarge` (or whatever instance type your masters use) is exhausted, the provisioning will fail with an AWS quota error visible in the machine's events. See the troubleshooting section below.

## Step 5: Apply the ControlPlaneMachineSet

Once all three machines are in `Running` phase and all three nodes are `Ready`, apply the CPMS:

```bash
oc apply -f controlplanemachineset.yaml
```

The CPMS webhook will now accept `replicas: 3` because there are exactly three control plane Machine objects.

## Step 6: Verify

```bash
oc get controlplanemachineset cluster -n openshift-machine-api
```

A healthy CPMS shows `Available=True`, `Progressing=False`, `Degraded=False`. Once this is in place, the operator will manage control plane machine lifecycle going forward — replacing failed masters, and (on clusters that support it) rolling out machine configuration changes.

---

## Troubleshooting

**AWS quota exceeded.** Sandbox environments limit the number of instances per type. If provisioning fails, you'll see something like `InsufficientInstanceCapacity` or a quota error in the machine's events. Options are limited in a sandbox — you may need to request a quota increase or try a smaller instance type (which requires adjusting the providerSpec).

**Subnet or security group not found.** The Machine API uses tag-based filters to locate subnets and security groups. If the tags in your providerSpec don't match the actual AWS resource tags, lookup fails. Compare the filter values in your Machine YAML against the actual tags on the subnet in the AWS console.

**IAM permissions error.** The credentials secret must allow `ec2:RunInstances` and related permissions. On RHPDS clusters this is preconfigured, but if you see IAM errors it means the cloud credential doesn't have permission to launch instances.

**etcd CrashLoopBackOff persists beyond 20 minutes.** Some transient CrashLoopBackOff is normal during the etcd revision rollout. If it continues well beyond convergence, check the etcd operator logs: `oc logs -n openshift-etcd-operator deployment/etcd-operator`. The most common cause is a network connectivity issue between the new nodes and the existing etcd members.

---

## Rollback

If you need to remove the additional masters, set the CPMS to `Inactive` first to stop the operator from reconciling:

```bash
oc patch controlplanemachineset cluster -n openshift-machine-api --type merge \
  -p '{"spec":{"state":"Inactive"}}'
```

Note that setting CPMS to Inactive does not delete the machines — it only stops operator management. To fully remove the additional masters, delete the Machine objects directly:

```bash
oc delete machine <master-1-name> <master-2-name> -n openshift-machine-api
```

Deleting a Machine object triggers the Machine API to terminate the corresponding EC2 instance. The node will be drained and removed from the cluster. Do not do this while etcd is unhealthy or you risk losing quorum.

---

## Files in This Directory

`master-1.yaml` — Machine object for the second control plane node.

`master-2.yaml` — Machine object for the third control plane node.

`controlplanemachineset.yaml` — The CPMS resource. Apply this last, only after all three masters are in `Running` phase.
