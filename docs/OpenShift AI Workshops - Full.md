# OpenShift AI Workshops

[Special Topics](#special-topics)

[Administrators](#administrators)

[Managing Administration Tasks from the OpenShift AI Dashboard](#managing-administration-tasks-from-the-openshift-ai-dashboard)

[Topic 1: Overview of Dashboard Administration and User Access](#topic-1:-overview-of-dashboard-administration-and-user-access)

[Topic 2: Customizing the Dashboard and Importing Images](#topic-2:-customizing-the-dashboard-and-importing-images)

[Topic 3: Managing Storage Resources (PVC, Classes, Connections)](#topic-3:-managing-storage-resources-\(pvc,-classes,-connections\))

[Topic 4: Administering Workbenches and Cluster Policies](#topic-4:-administering-workbenches-and-cluster-policies)

[Topic 5: Telemetry and Usage Data Collection](#topic-5:-telemetry-and-usage-data-collection)

[Managing OpenShift AI – Admin Tasks for Users, Resources, Accelerators, and Workloads](#managing-openshift-ai-–-admin-tasks-for-users,-resources,-accelerators,-and-workloads)

[Topic 1: Managing Users and Groups](#topic-1:-managing-users-and-groups)

[Topic 2: Enabling Custom Images in OpenShift AI](#topic-2:-enabling-custom-images-in-openshift-ai)

[Topic 3: Managing Applications in the Dashboard](#topic-3:-managing-applications-in-the-dashboard)

[Topic 4: Custom Deployment Resources & Accelerators](#topic-4:-custom-deployment-resources-&-accelerators)

[Topic 5: Workload Resources with Kueue & Distributed Workloads](#topic-5:-workload-resources-with-kueue-&-distributed-workloads)

[Topic 6: Configuring External OIDC Identity Providers & Data Backup](#topic-6:-configuring-external-oidc-identity-providers-&-data-backup)

[Creating a Workbench – Custom Images and Programmatic Provisioning in Red Hat OpenShift AI 3](#creating-a-workbench-–-custom-images-and-programmatic-provisioning-in-red-hat-openshift-ai-3)

[Topic 1: Creating a Custom Image by Using the ImageStream CRD](#topic-1:-creating-a-custom-image-by-using-the-imagestream-crd)

[Topic 2: Creating a Workbench by Using the Notebook CRD](#topic-2:-creating-a-workbench-by-using-the-notebook-crd)

[Configuring Your Model-Serving Platform – Deploying and Serving Models in Red Hat OpenShift AI 3](#configuring-your-model-serving-platform-–-deploying-and-serving-models-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Model Serving in OpenShift AI](#topic-1:-overview-of-model-serving-in-openshift-ai)

[Topic 2: Enabling and Managing the Model Serving Platform](#topic-2:-enabling-and-managing-the-model-serving-platform)

[Topic 3: Deploying Models with ServingRuntimes and InferenceServices](#topic-3:-deploying-models-with-servingruntimes-and-inferenceservices)

[Topic 4: Accelerator Support and Optimization](#topic-4:-accelerator-support-and-optimization)

[Topic 5 (Optional – for Interested Participants): NVIDIA NIM Model Serving](#topic-5-\(optional-–-for-interested-participants\):-nvidia-nim-model-serving)

[Managing Model Registries in Red Hat OpenShift AI Self-Managed 3](#managing-model-registries-in-red-hat-openshift-ai-self-managed-3)

[Topic 1: Overview of Model Registries and the Model Catalog](#topic-1:-overview-of-model-registries-and-the-model-catalog)

[Topic 2: Enabling the Model Registry Component](#topic-2:-enabling-the-model-registry-component)

[Topic 3: Creating and Configuring a Model Registry](#topic-3:-creating-and-configuring-a-model-registry)

[Topic 4: Managing Permissions and Access](#topic-4:-managing-permissions-and-access)

[Topic 5: Editing, Deleting, and Best Practices](#topic-5:-editing,-deleting,-and-best-practices)

[Data scientists, ML engineers, and MLOps practitioners](#data-scientists,-ml-engineers,-and-mlops-practitioners)

[Working in Your Data Science IDE – Maximizing Productivity with JupyterLab, code-server, and More in Red Hat OpenShift AI 3](#working-in-your-data-science-ide-–-maximizing-productivity-with-jupyterlab,-code-server,-and-more-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Data Science IDEs in OpenShift AI](#topic-1:-overview-of-data-science-ides-in-openshift-ai)

[Topic 2: Working Effectively in JupyterLab](#topic-2:-working-effectively-in-jupyterlab)

[Topic 3: Working Effectively in code-server (VS Code Web)](#topic-3:-working-effectively-in-code-server-\(vs-code-web\))

[Topic 4: Best Practices, Customization, and Troubleshooting](#topic-4:-best-practices,-customization,-and-troubleshooting)

[Working with AI Pipelines – Building, Scheduling, and Tracking ML Workflows in Red Hat OpenShift AI 3](#working-with-ai-pipelines-–-building,-scheduling,-and-tracking-ml-workflows-in-red-hat-openshift-ai-3)

[Topic 1: Overview of AI Pipelines and Pipeline Server Setup](#topic-1:-overview-of-ai-pipelines-and-pipeline-server-setup)

[Topic 2: Importing, Versioning, and Managing Pipelines](#topic-2:-importing,-versioning,-and-managing-pipelines)

[Topic 3: Creating Experiments, Running, and Scheduling Pipelines](#topic-3:-creating-experiments,-running,-and-scheduling-pipelines)

[Topic 4: Monitoring Runs, Logs, Artifacts, and Caching](#topic-4:-monitoring-runs,-logs,-artifacts,-and-caching)

[Topic 5: Building Pipelines in JupyterLab with Elyra (Hands-On Focus)](#topic-5:-building-pipelines-in-jupyterlab-with-elyra-\(hands-on-focus\))

[Topic 6: Troubleshooting and Best Practices](#topic-6:-troubleshooting-and-best-practices)

[Working on Projects – Organizing Collaborative AI/ML Workflows in Red Hat OpenShift AI 3](#working-on-projects-–-organizing-collaborative-ai/ml-workflows-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Projects and Their Components](#topic-1:-overview-of-projects-and-their-components)

[Topic 2: Creating, Updating, and Deleting Projects](#topic-2:-creating,-updating,-and-deleting-projects)

[Topic 3: Creating and Managing Workbenches in a Project](#topic-3:-creating-and-managing-workbenches-in-a-project)

[Topic 4: Managing Connections and Cluster Storage](#topic-4:-managing-connections-and-cluster-storage)

[Topic 5: Managing Access and Project-Scoped Resources](#topic-5:-managing-access-and-project-scoped-resources)

[Working with Data in an S3-Compatible Object Store – Accessing and Managing Data from Workbenches in Red Hat OpenShift AI 3](#working-with-data-in-an-s3-compatible-object-store-–-accessing-and-managing-data-from-workbenches-in-red-hat-openshift-ai-3)

[Topic 1: Overview of S3-Compatible Storage in OpenShift AI](#topic-1:-overview-of-s3-compatible-storage-in-openshift-ai)

[Topic 2: Setting Up the Environment in a Workbench](#topic-2:-setting-up-the-environment-in-a-workbench)

[Topic 3: Creating and Verifying an S3 Client](#topic-3:-creating-and-verifying-an-s3-client)

[Topic 4: Core Bucket and Object Operations](#topic-4:-core-bucket-and-object-operations)

[Topic 5: Endpoint Formatting, Self-Signed Certs, and Troubleshooting](#topic-5:-endpoint-formatting,-self-signed-certs,-and-troubleshooting)

[Experimenting with Models in the Gen AI Playground – Prototyping, RAG, and Tool Integration in Red Hat OpenShift AI 3](#experimenting-with-models-in-the-gen-ai-playground-–-prototyping,-rag,-and-tool-integration-in-red-hat-openshift-ai-3)

[Topic 1: Overview of the Gen AI Playground and Prerequisites](#topic-1:-overview-of-the-gen-ai-playground-and-prerequisites)

[Topic 2: Configuring a Playground Instance](#topic-2:-configuring-a-playground-instance)

[Topic 3: Interacting with Models – Basic Chat and Parameter Tuning](#topic-3:-interacting-with-models-–-basic-chat-and-parameter-tuning)

[Topic 4: Testing Retrieval-Augmented Generation (RAG)](#topic-4:-testing-retrieval-augmented-generation-\(rag\))

[Topic 5: Integrating MCP Servers and Exporting Configurations (Optional Extension)](#topic-5:-integrating-mcp-servers-and-exporting-configurations-\(optional-extension\))

[Building AI/Agentic Applications with Llama Stack in Red Hat OpenShift AI 3](#building-ai/agentic-applications-with-llama-stack-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Llama Stack and Its APIs](#topic-1:-overview-of-llama-stack-and-its-apis)

[Topic 2: Activating the Llama Stack Operator and Deploying a Server](#topic-2:-activating-the-llama-stack-operator-and-deploying-a-server)

[Topic 3: Deploying a RAG Stack – Vector Stores and Inference Integration](#topic-3:-deploying-a-rag-stack-–-vector-stores-and-inference-integration)

[Topic 4: Advanced RAG Features – Evaluation and Agents](#topic-4:-advanced-rag-features-–-evaluation-and-agents)

[Customize Models to Build Generative AI Applications – Fine-Tuning and Adaptation in Red Hat OpenShift AI 3](#customize-models-to-build-generative-ai-applications-–-fine-tuning-and-adaptation-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Model Customization Workflow](#topic-1:-overview-of-model-customization-workflow)

[Topic 2: Setting Up Your Working Environment](#topic-2:-setting-up-your-working-environment)

[Topic 3: Preparing Data with Docling](#topic-3:-preparing-data-with-docling)

[Topic 4: Generating Synthetic Data with SDG Hub](#topic-4:-generating-synthetic-data-with-sdg-hub)

[Topic 5: Fine-Tuning Models with Training Hub](#topic-5:-fine-tuning-models-with-training-hub)

[Topic 6: End-to-End Workflow and Best Practices](#topic-6:-end-to-end-workflow-and-best-practices)

[Deploying Models on the Single-Model Serving Platform – KServe RawDeployment in Red Hat OpenShift AI 3](#deploying-models-on-the-single-model-serving-platform-–-kserve-rawdeployment-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Single-Model Serving Platform and Model Storage](#topic-1:-overview-of-single-model-serving-platform-and-model-storage)

[Topic 2: Preparing and Storing Models](#topic-2:-preparing-and-storing-models)

[Topic 4: Deploying Models via YAML/CLI (Advanced Control)](#topic-4:-deploying-models-via-yaml/cli-\(advanced-control\))

[Topic 5: Advanced Configurations, Verification, and Monitoring](#topic-5:-advanced-configurations,-verification,-and-monitoring)

[Topic 6: Troubleshooting and Best Practices](#topic-6:-troubleshooting-and-best-practices-1)

[Evaluating AI Systems – Assessing LLMs and RAG Pipelines in Red Hat OpenShift AI 3](#evaluating-ai-systems-–-assessing-llms-and-rag-pipelines-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Evaluating AI Systems in OpenShift AI](#topic-1:-overview-of-evaluating-ai-systems-in-openshift-ai)

[Topic 2: Setting Up LM-Eval for LLM Evaluations](#topic-2:-setting-up-lm-eval-for-llm-evaluations)

[Topic 3: Running and Monitoring LM-Eval Jobs](#topic-3:-running-and-monitoring-lm-eval-jobs)

[Topic 4: Evaluating RAG Systems with Ragas](#topic-4:-evaluating-rag-systems-with-ragas)

[Topic 5: Advanced Integrations with Llama Stack and Best Practices](#topic-5:-advanced-integrations-with-llama-stack-and-best-practices)

[Working with Model Registries – Registering, Versioning, and Promoting Models in Red Hat OpenShift AI 3](#working-with-model-registries-–-registering,-versioning,-and-promoting-models-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Model Registries vs. Model Catalog](#topic-1:-overview-of-model-registries-vs.-model-catalog)

[Topic 2: Registering Models and Adding Versions](#topic-2:-registering-models-and-adding-versions)

[Topic 3: Viewing and Editing Model/Version Metadata](#topic-3:-viewing-and-editing-model/version-metadata)

[Topic 4: Deploying and Managing Deployed Model Versions](#topic-4:-deploying-and-managing-deployed-model-versions)

[Topic 5: Archiving and Restoring Models/Versions](#topic-5:-archiving-and-restoring-models/versions)

[Working with the Model Catalog – Discovering, Evaluating, Registering, and Deploying Gen AI Models in Red Hat OpenShift AI 3](#working-with-the-model-catalog-–-discovering,-evaluating,-registering,-and-deploying-gen-ai-models-in-red-hat-openshift-ai-3)

[Topic 1: Overview of the Model Catalog and Its Role](#topic-1:-overview-of-the-model-catalog-and-its-role)

[Topic 2: Searching, Filtering, and Viewing Model Details](#topic-2:-searching,-filtering,-and-viewing-model-details)

[Topic 3: Evaluating Models with Performance Insights](#topic-3:-evaluating-models-with-performance-insights)

[Topic 5: Deploying Models Directly from the Catalog](#topic-5:-deploying-models-directly-from-the-catalog)

[Working with Machine Learning Features – Hands-On with Feature Store in Red Hat OpenShift AI 3](#working-with-machine-learning-features-–-hands-on-with-feature-store-in-red-hat-openshift-ai-3)

[Working with Machine Learning Features – Hands-On with Feature Store in Red Hat OpenShift AI 3](#working-with-machine-learning-features-–-hands-on-with-feature-store-in-red-hat-openshift-ai-3-1)

[Topic 1: Overview of Machine Learning Features and Feature Store](#topic-1:-overview-of-machine-learning-features-and-feature-store)

[Topic 2: Configuring and Connecting to Feature Store (Workbench Integration)](#topic-2:-configuring-and-connecting-to-feature-store-\(workbench-integration\))

[Topic 3: Defining Machine Learning Features](#topic-3:-defining-machine-learning-features)

[Topic 4: Retrieving Features for Model Training and Inference](#topic-4:-retrieving-features-for-model-training-and-inference)

[Topic 5: Compute Engines and Advanced Pipelines (Ray/Spark)](#topic-5:-compute-engines-and-advanced-pipelines-\(ray/spark\))

[Working with Distributed Workloads – Scaling Training and Processing in Red Hat OpenShift AI 3](#working-with-distributed-workloads-–-scaling-training-and-processing-in-red-hat-openshift-ai-3)

[Topic 1: Overview of Distributed Workloads and Key Technologies](#topic-1:-overview-of-distributed-workloads-and-key-technologies)

[Topic 2: Preparing the Environment and Ray-Based Workloads](#topic-2:-preparing-the-environment-and-ray-based-workloads)

[Topic 3: Training Operator-Based Workloads – PyTorch Jobs](#topic-3:-training-operator-based-workloads-–-pytorch-jobs)

[Topic 4: Monitoring and Viewing Distributed Workloads](#topic-4:-monitoring-and-viewing-distributed-workloads)

[Topic 5: Troubleshooting Common Problems](#topic-5:-troubleshooting-common-problems)

[Workshop for Inference-Focus Roles](#workshop-for-inference-focus-roles)

[Getting Started with Red Hat AI Inference Server – Optimized LLM Inference on Accelerators](#getting-started-with-red-hat-ai-inference-server-–-optimized-llm-inference-on-accelerators)

[Topic 1: Overview of Red Hat AI Inference Server](#topic-1:-overview-of-red-hat-ai-inference-server)

[Topic 2: Prerequisites and Image Pulling](#topic-2:-prerequisites-and-image-pulling)

[Topic 3: Starting the Inference Server](#topic-3:-starting-the-inference-server)

[Topic 4: Testing Inference and API Usage](#topic-4:-testing-inference-and-api-usage)

[Topic 5: Performance Validation and Troubleshooting](#topic-5:-performance-validation-and-troubleshooting)

[Deploying Red Hat AI Inference Server in a Disconnected Environment – Air-Gapped Inference in OpenShift](#deploying-red-hat-ai-inference-server-in-a-disconnected-environment-–-air-gapped-inference-in-openshift)

[Topic 1: Overview of Disconnected Deployment and Air-Gapped Constraints](#topic-1:-overview-of-disconnected-deployment-and-air-gapped-constraints)

[Topic 2: Setting Up the Mirror Registry on Bastion Host](#topic-2:-setting-up-the-mirror-registry-on-bastion-host)

[Topic 3: Mirroring Required Images](#topic-3:-mirroring-required-images)

[Topic 4: Installing NFD and NVIDIA GPU Operators from Mirror](#topic-4:-installing-nfd-and-nvidia-gpu-operators-from-mirror)

[Topic 5: Deploying the Inference Server and Serving a Model](#topic-5:-deploying-the-inference-server-and-serving-a-model)

[Topic 6: Testing Inference and Troubleshooting](#topic-6:-testing-inference-and-troubleshooting)

[Deploying Red Hat AI Inference Server in OpenShift Container Platform – Accelerator-Optimized Inference in OCP Clusters](#deploying-red-hat-ai-inference-server-in-openshift-container-platform-–-accelerator-optimized-inference-in-ocp-clusters)

[Topic 1: Overview of Red Hat AI Inference Server in OpenShift](#topic-1:-overview-of-red-hat-ai-inference-server-in-openshift)

[Topic 2: Installing Prerequisite Operators – NFD and GPU Drivers](#topic-2:-installing-prerequisite-operators-–-nfd-and-gpu-drivers)

[Topic 3: Preparing Secrets, Storage, and Namespace](#topic-3:-preparing-secrets,-storage,-and-namespace)

[Topic 4: Deploying the Inference Server and Serving a Model](#topic-4:-deploying-the-inference-server-and-serving-a-model)

[Topic 5: Testing Inference and Monitoring](#topic-5:-testing-inference-and-monitoring)

[Topic 6: Troubleshooting and Best Practices](#topic-6:-troubleshooting-and-best-practices-2)

[Inference Serving Language Models in OCI-Compliant Model Containers – Modelcars for Efficient Deployment in Red Hat AI Inference Server 3](#inference-serving-language-models-in-oci-compliant-model-containers-–-modelcars-for-efficient-deployment-in-red-hat-ai-inference-server-3)

[Topic 1: Overview of OCI-Compliant Model Containers (Modelcars)](#topic-1:-overview-of-oci-compliant-model-containers-\(modelcars\))

[Topic 2: Building and Pushing a Modelcar Image](#topic-2:-building-and-pushing-a-modelcar-image)

[Topic 3: Serving Modelcars Locally with Podman](#topic-3:-serving-modelcars-locally-with-podman)

[Topic 4: Deploying Modelcars in OpenShift Container Platform](#topic-4:-deploying-modelcars-in-openshift-container-platform)

[Topic 5: Testing Inference and Verification](#topic-5:-testing-inference-and-verification)

[Topic 6: Troubleshooting and Best Practices](#topic-6:-troubleshooting-and-best-practices-3)

[vLLM Server Arguments – Fine-Tuning Inference Performance and Behavior in Red Hat AI Inference Server 3](#vllm-server-arguments-–-fine-tuning-inference-performance-and-behavior-in-red-hat-ai-inference-server-3)

[Topic 1: Overview of vLLM Server Arguments and Key Categories](#topic-1:-overview-of-vllm-server-arguments-and-key-categories)

[Topic 2: Core Model Loading and Quantization Arguments](#topic-2:-core-model-loading-and-quantization-arguments)

[Topic 3: Performance & Multi-GPU Optimizations](#topic-3:-performance-&-multi-gpu-optimizations)

[Topic 4: Generation & Sampling Parameters](#topic-4:-generation-&-sampling-parameters)

[Topic 5: API Customization, LoRA, Logging, and Advanced Features](#topic-5:-api-customization,-lora,-logging,-and-advanced-features)

[Topic 6: Benchmarking, Troubleshooting, and Best Practices](#topic-6:-benchmarking,-troubleshooting,-and-best-practices)

[Red Hat AI Model Optimization Toolkit – Compressing & Quantizing LLMs for Efficient Inference](#red-hat-ai-model-optimization-toolkit-–-compressing-&-quantizing-llms-for-efficient-inference)

[Topic 1: Overview of Red Hat AI Model Optimization Toolkit](#topic-1:-overview-of-red-hat-ai-model-optimization-toolkit)

[Topic 2: Setting Up the Environment and Pulling the Container](#topic-2:-setting-up-the-environment-and-pulling-the-container)

[Topic 3: Applying Basic Quantization Recipes](#topic-3:-applying-basic-quantization-recipes)

[Topic 4: Advanced Compression – Multi-Method, Sparsity, Transforms, and MoE](#topic-4:-advanced-compression-–-multi-method,-sparsity,-transforms,-and-moe)

[Topic 5: Integrating Optimized Models with Inference Server](#topic-5:-integrating-optimized-models-with-inference-server)

[Topic 6: Troubleshooting, Limitations, and Best Practices](#topic-6:-troubleshooting,-limitations,-and-best-practices)

| Section Name | Title / Workshop Name | Short Sentence Description | Primary Technologies / Components |
| ----- | ----- | ----- | ----- |
| Technical Deep Dive on Special Topics | Red Hat Model Validation and Security Scanning Process | Overview of Red Hat's model validation pipeline, security scanning, and trusted container/image practices | Red Hat HuggingFace Validated Models, UBI-minimal, ModelCar, synk, unicode, trivy, TSSC |
| Technical Deep Dive on Special Topics | TrustyAI Model Observability and Governance | Deep dive into model monitoring, evaluation, governance, and guardrails in production environments | TrustyAI, LMEval, GuideLLM, LLM Compressor, Guardrails Orchestrator |
| Technical Deep Dive on Special Topics | Intelligent Routing Cluster-Level and Hybrid Multi-Cluster | Explore intelligent routing, load balancing, and hybrid multi-cluster inference strategies | Red Hat Connectivity Link (RHCL), vLLM, llm-d, API Gateway (in development, etc.) |
| Technical Deep Dive on Special Topics | Models-as-a-Service (MaaS) | Architecture and deployment patterns for offering models as managed API services | 3Scale API (Gateway, Manager, Developer Portal, Admin Portal), OpenShift AI |
| Technical Deep Dive on Special Topics | Red Hat Developer Lightspeed – AI-Powered Code Assistance for Developers | Explore how Red Hat Developer Lightspeed accelerates coding with context-aware suggestions, code generation, explanations, and refactoring directly in IDEs | Red Hat Developer Lightspeed, VS Code extension, RHEL integration, LLM-based code completion & chat |
| **Section Name** | **Title / Workshop Name** | **Short Sentence Description** | **Primary Technologies / Components** |
| Workshop for Administrators | Managing Administration Tasks from the OpenShift AI Dashboard | Perform day-to-day admin operations directly from the OpenShift AI dashboard UI | OdhDashboardConfig, Dashboard Settings UI, Workbench admin |
| Workshop for Administrators | Managing OpenShift AI – Admin Tasks for Users, Resources, Accelerators, and Workloads | Perform core cluster admin operations: users/groups, images, accelerators, Kueue, OIDC, backups, monitoring | OdhDashboardConfig, Kueue, NVIDIA GPU Operator, OIDC, OADP |
| Workshop for Administrators | Creating a Workbench | Build and register custom notebook images and provision secure workbenches programmatically | ImageStream CRD, Notebook CRD (Kubeflow), OpenShift CLI |
| Workshop for Administrators | Configuring Your Model-Serving Platform – KServe | Deploy models using KServe runtimes, manage InferenceServices, and optimize for accelerators (incl. NIM) | KServe, ServingRuntime, InferenceService, vLLM, NVIDIA NIM (optional) |
| Workshop for Administrators | Managing Model Registries | Create, secure, and manage MySQL-backed model registries for versioning and governance | Model Registry component, RBAC, MySQL |
| **Section Name** | **Title / Workshop Name** | **Short Sentence Description** | **Primary Technologies / Components** |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working in Your Data Science IDE | Use JupyterLab, code-server (VS Code), and RStudio effectively inside workbenches | JupyterLab, code-server, RStudio Server TP, Git integration |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working with AI Pipelines | Build, import, run, schedule, and monitor ML pipelines using Kubeflow Pipelines and Elyra | Kubeflow Pipelines, Elyra, KFP SDK |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working with Data in an S3-Compatible Object Store | Connect workbenches to S3 storage and perform bucket/object operations using Boto3 | Boto3, S3 connections, workbench env vars |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working on Projects | Create and manage projects as collaborative workspaces with workbenches, storage, connections, and access | Projects (namespaces), Workbenches, Connections, RBAC |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Experimenting with Models in the Gen AI Playground | Interactively test prompts, RAG, MCP tools, and parameters in the browser-based playground | Gen AI Playground, Llama Stack, RAG support |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Building AI/Agentic Applications with Llama Stack | Deploy Llama Stack servers and use OpenAI-compatible APIs for RAG and agentic workflows | Llama Stack Operator, LlamaStackDistribution, vLLM, Milvus/pgvector |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Customize Models to Build Generative AI Applications | Prepare data (Docling), generate synthetic data (SDG Hub), and fine-tune models (Training Hub) | Docling, SDG Hub, Training Hub, Kubeflow Trainer Operator |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Deploying Models on the Single-Model Serving Platform | Deploy large models using KServe RawDeployment mode with OCI/PVC storage and advanced configurations | KServe RawDeployment, InferenceService, vLLM, OpenVINO |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Evaluating AI Systems | Evaluate LLMs and RAG systems using LM-Eval, Ragas, and Llama Stack integrations | TrustyAI, LM-Eval, Ragas, Llama Stack |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working with Model Registries | Register, version, add metadata to, deploy, and lifecycle-manage models in the registry | Model Registry UI, InferenceService integration |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working with the Model Catalog | Discover, evaluate, register, and deploy curated generative AI models from trusted providers | Model Catalog (AI Hub), Performance Insights |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working with Distributed Workloads | Run scalable multi-node training and data processing jobs with Kueue queuing and Ray/Kubeflow | Kueue, Ray (CodeFlare), Kubeflow Training Operator (PyTorch) |
| Workshop for Data Scientists, ML Engineers, MLOps Practicioners | Working with Machine Learning Features – Feature Store | Define, store, materialize and retrieve ML features using a centralized Feast-based Feature Store | Feature Store (Feast), Ray/Spark engines |
| **Section Name** | **Title / Workshop Name** | **Short Sentence Description** | **Primary Technologies / Components** |
| Workshops for Inference-Focus Roles | Getting Started with Red Hat AI Inference Server | Launch high-performance LLM inference using the vLLM-based container on local GPU servers | Red Hat AI Inference Server (vLLM), Podman, NVIDIA/AMD/TPU/Spire |
| Workshops for Inference-Focus Roles | Deploying Red Hat AI Inference Server in a Disconnected Environment | Set up air-gapped inference in OpenShift using a mirrored registry and persistent storage | vLLM, oc mirror, NFD \+ NVIDIA GPU Operator, disconnected deployment |
| Workshops for Inference-Focus Roles | Inference Serving Language Models in OCI-Compliant Model Containers | Package models into OCI modelcar containers for registry distribution and efficient serving | Modelcars (OCI), vLLM, Podman / OpenShift Deployment |
| Workshops for Inference-Focus Roles | vLLM Server Arguments | Fine-tune inference behavior, performance, quantization, LoRA, and API using vLLM command-line flags | vLLM engine arguments, environment variables |
| Workshops for Inference-Focus Roles | Red Hat AI Model Optimization Toolkit | Compress and quantize models (INT4/FP8/NVFP4, sparsity, transforms) before inference | LLM Compressor, Model Optimization Toolkit, compressed-tensors format |

| Section Name | Short Sentence Description | Primary Technologies / Components |
| ----- | ----- | ----- |
| **Technical Deep Dive on Special Topics** | In-depth exploration of advanced AI capabilities, governance, security, routing, and service architectures | Red Hat Developer Lightspeed, TrustyAI (LM-Eval, Ragas), Guardrails Orchestrator, RHCL, 3Scale API Gateway, Model Validation Pipeline (trivy, synk, TSSC) |
| **Workshop for Administrators** | Hands-on sessions focused on cluster setup, administration, security, resource management, and platform configuration | OpenShift AI Dashboard, OdhDashboardConfig, Kueue, Model Registry, KServe, ImageStream/Notebook CRDs, NVIDIA/AMD GPU Operators, OIDC, OADP |
| **Workshop for Data Scientists, ML Engineers, MLOps Practitioners** | Practical workshops on building, experimenting, customizing, evaluating, and deploying AI/ML workflows and models | JupyterLab/code-server, Kubeflow Pipelines \+ Elyra, Feature Store (Feast), Llama Stack, Docling/SDG Hub/Training Hub, Model Catalog/Registry, KServe InferenceService, TrustyAI evaluation tools |
| **Workshop for Inference-Focus Roles** | Specialized sessions on high-performance, scalable, and optimized LLM inference across local, cluster, and disconnected environments | Red Hat AI Inference Server (vLLM), Modelcars (OCI), vLLM server arguments, Model Optimization Toolkit (LLM Compressor), disconnected mirroring (oc mirror), NVIDIA GPU Operator |
| **Workshops for AI Developers** | Developer-centric sessions on AI-assisted coding, rapid prototyping, and integration of generative AI tools into daily development workflows | Red Hat Developer Lightspeed (VS Code extension, RHEL integration), Gen AI Playground, Llama Stack APIs, code-server, Git integration, Python/Jupyter environments |

# Special Topics {#special-topics}

## NVIDIA GPU Management in OpenShift – Configuration, Utilization, and Performance Tuning

**Description:**

Master NVIDIA GPU acceleration in OpenShift Container Platform for AI/ML workloads with this focused deep-dive. Participants will install and configure the NVIDIA GPU Operator, understand static vs. dynamic allocation (MIG, MPS, DRA, DAS), monitor utilization vs. saturation, enable RDMA for distributed training, and apply performance tuning to avoid bottlenecks and maximize throughput on NVIDIA hardware.

You'll learn to:

* Install and verify the NVIDIA GPU Operator with proper driver and device-plugin setup.  
* Configure static GPU assignment vs. dynamic features (MIG for slicing, MPS for sharing, DRA/DAS for flexible claims).  
* Monitor real-time GPU utilization, memory saturation, and compute pressure using OpenShift metrics and nvidia-smi.  
* Enable RDMA and NVIDIA Network Operator for high-bandwidth GPU-to-GPU communication.  
* Tune performance: MIG profiles, MPS servers, scheduler placement, and saturation avoidance strategies.

Includes live oc demos, guided YAML exercises (Operator subscription, MIG config, DRA claims, DAS policies), verification steps (node labels, pod GPU allocation, metrics dashboards), troubleshooting tips (driver mismatches, MIG config errors, saturation symptoms), and NVIDIA-specific best practices for production AI clusters.

**Audience:** OpenShift cluster administrators, platform engineers, and AI infrastructure teams using NVIDIA GPUs; experience with OpenShift CLI and basic Kubernetes scheduling recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift Container Platform 4.20+ cluster with cluster-admin privileges.  
* At least one node with NVIDIA GPU(s) (A100, H100, or T4+ with CUDA 12+).  
* oc CLI installed and logged in as cluster-admin.  
* A test namespace with sample CUDA workloads (e.g., simple nvidia-smi pod).  
* Optional: Prometheus monitoring enabled for GPU metrics visualization.

**Duration:** 90–120 minutes, including hands-on labs.

**Format:** Slides/overview → Live oc \+ console demos → Guided hands-on YAML exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Install and verify the NVIDIA GPU Operator with full device detection.  
* Configure MIG, MPS, DRA, and DAS for static and dynamic GPU sharing.  
* Monitor NVIDIA GPU utilization, saturation, and performance metrics in real time.  
* Enable RDMA and optimize for multi-GPU AI workloads.

### Topic 1: Overview of NVIDIA GPU Management in OpenShift

**Goal:** Understand static vs. dynamic allocation and key NVIDIA features.

**Core Concepts to Cover:**

* Static: fixed resources (requests/limits).  
* Dynamic: MIG (slicing), MPS (time-sharing), DRA/DAS (claims/slicing).  
* Utilization vs. saturation: high util good, memory/compute saturation bad.  
* NVIDIA-specific: MIG profiles, MPS servers, RDMA via Network Operator.

### Topic 2: Installing and Configuring the NVIDIA GPU Operator

**Goal:** Get GPUs detected and usable.

**Core Concepts to Cover:**

* OperatorHub install (certified channel).  
* NFD \+ NVIDIA drivers/toolkit/device-plugin.  
* Verification: node labels (nvidia.com/gpu), pods in nvidia-gpu-operator namespace.  
* Hands-on: Subscribe → wait for validation → check GPU capacity.

### Topic 3: Static vs. Dynamic NVIDIA Features (MIG, MPS, DRA, DAS)

**Goal:** Configure and compare allocation strategies.

**Core Concepts to Cover:**

* MIG: slice A100/H100 into isolated instances.  
* MPS: share context across processes.  
* DRA/DAS: dynamic claims and slicing.  
* Hands-on: Enable MIG → create pod with MIG profile → compare vs. standard pod.

### Topic 4: RDMA and NVIDIA Network Optimization

**Goal:** Enable high-bandwidth GPU communication.

**Core Concepts to Cover:**

* NVIDIA Network Operator: MOFED, SR-IOV, RDMA.  
* Use cases: tensor parallelism, distributed training.  
* Hands-on: Deploy Network Operator → pod with RDMA request → verify device.

### Topic 5: Monitoring, Saturation Avoidance, and Performance Tuning

**Goal:** Detect and resolve GPU bottlenecks.

**Core Concepts to Cover:**

* Metrics: utilization %, memory used, saturation events.  
* Tools: OCP console, Prometheus, nvidia-smi in debug pod.  
* Tuning: gpu-memory-utilization, scheduler affinity.  
* Hands-on: Stress pod → watch saturation → tune → re-run.

### Topic 6: Troubleshooting, Best Practices & Q\&A

**Goal:** Handle NVIDIA-specific issues and adopt production patterns.

**Core Concepts to Cover:**

* Common: driver version mismatch, MIG config failure, DRA claim errors.  
* Best practices: MIG for isolation, MPS for density, DRA/DAS for sharing.  
* Discussion: How many GPUs per node? Static vs. dynamic in your workloads?

## AMD GPU Management in OpenShift – Configuration, Utilization, and Performance Tuning

**Description:**

Master AMD GPU acceleration in OpenShift Container Platform for AI/ML workloads with this focused deep-dive. Participants will install and configure the AMD GPU Operator, understand static, monitor utilization vs. saturation, enable ROCm features for high-performance computing, and apply performance tuning techniques to maximize accelerator efficiency on AMD hardware (MI300X and later).

You'll learn to:

* Install and verify the AMD GPU Operator with ROCm drivers and device plugin.  
* Configure static GPU assignment vs. dynamic sharing strategies.  
* Monitor GPU utilization, memory saturation, and compute pressure using OpenShift metrics and rocminfo.  
* Enable ROCm-specific optimizations for multi-GPU and distributed workloads.  
* Apply performance best practices: avoid saturation, optimize scheduler placement, and profile with AMD tools.

Includes live oc demos, guided YAML exercises (Operator subscription, pod configs, metrics queries), verification steps (node labels, pod GPU allocation, metrics dashboards), troubleshooting tips (driver mismatches, saturation symptoms, ROCm compatibility), and AMD-specific best practices for production AI clusters.

**Audience:** OpenShift cluster administrators, platform engineers, and AI infrastructure teams using AMD GPUs; experience with OpenShift CLI and basic Kubernetes scheduling recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift Container Platform 4.20+ cluster with cluster-admin privileges.  
* At least one node with AMD GPU(s) (MI300X or later with ROCm 6+).  
* oc CLI installed and logged in as cluster-admin.  
* A test namespace with sample ROCm workloads (e.g., simple rocminfo pod).  
* Optional: Prometheus monitoring enabled for GPU metrics visualization.

**Duration:** 90–120 minutes, including hands-on labs.

**Format:** Slides/overview → Live oc \+ console demos → Guided hands-on YAML exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Install and verify the AMD GPU Operator with full device detection.  
* Configure static and dynamic GPU allocation strategies for AMD hardware.  
* Monitor AMD GPU utilization, saturation, and performance metrics in real time.  
* Optimize ROCm workloads with saturation avoidance and scheduler tuning.

### Topic 1: Overview of AMD GPU Management in OpenShift

**Goal:** Understand allocation strategies and key AMD features.

**Core Concepts to Cover:**

* Static vs. dynamic allocation in ROCm context.  
* Utilization vs. saturation: compute/memory pressure indicators.  
* AMD-specific: ROCm drivers, multi-GPU support, high-bandwidth interconnects.

### Topic 2: Installing and Configuring the AMD GPU Operator

**Goal:** Get AMD GPUs detected and usable.

**Core Concepts to Cover:**

* OperatorHub install (community channel).  
* KMM (Kernel Module Management) \+ ROCm drivers/device-plugin.  
* Verification: node labels (amd.com/gpu), pods in amd-gpu-operator namespace.  
* Hands-on: Subscribe → wait for validation → check GPU capacity.

### Topic 3: Static vs. Dynamic Allocation on AMD GPUs

**Goal:** Configure and compare sharing strategies.

**Core Concepts to Cover:**

* Static: fixed resources per pod.  
* Dynamic: time-slicing, multi-process sharing (ROCm equivalents).  
* Hands-on: Deploy pod with GPU request → compare single vs. multi-pod density.

### Topic 4: Monitoring Utilization, Saturation, and Performance Tuning

**Goal:** Detect and avoid AMD GPU bottlenecks.

**Core Concepts to Cover:**

* Metrics: utilization %, memory used, saturation events.  
* Tools: OCP console, Prometheus, rocminfo in debug pod.  
* Tuning: resource limits, scheduler affinity.  
* Hands-on: Stress pod → watch saturation → tune → re-run.

### Topic 5: ROCm-Specific Optimizations and Best Practices

**Goal:** Maximize AMD GPU performance in AI workloads.

**Core Concepts to Cover:**

* Multi-GPU support, high-bandwidth interconnects.  
* Best practices: avoid saturation alerts, use affinity for NUMA-aware placement.  
* Hands-on: Deploy multi-GPU pod → verify allocation → profile performance.

### Topic 6: Troubleshooting, Best Practices & Q\&A

**Goal:** Handle AMD-specific issues and adopt production patterns.

**Core Concepts to Cover:**

* Common: ROCm driver version mismatch, device not found, saturation throttling.  
* Best practices: monitor with rocminfo, combine with DRA when available.  
* Discussion: AMD vs. NVIDIA trade-offs in your workloads?

## OpenShift Lightspeed – AI-Powered Assistance in the OpenShift Web Console

**Description:**

Accelerate OpenShift administration and troubleshooting with OpenShift Lightspeed — the built-in AI assistant available directly in the OpenShift web console ([Technology Preview in OCP 4.18+](https://docs.redhat.com/en/documentation/openshift_container_platform/4.20/html-single/release_notes/index#ocp-release-notes-web-console-tech-preview_release-notes)). This hands-on session teaches how Lightspeed provides natural-language explanations, step-by-step guidance, resource recommendations, YAML generation, and troubleshooting suggestions for cluster management, workloads, networking, storage, and security — all without leaving the console.

You'll learn to:

* Enable and configure OpenShift Lightspeed in your cluster.  
* Use natural-language queries for explanations and guidance (e.g., “Why is my pod stuck in Pending?”).  
* Generate or edit YAML directly from the assistant (Deployments, Routes, NetworkPolicies).  
* Get contextual recommendations for resources, security contexts, and best practices.  
* Understand enterprise controls: data privacy, on-cluster inference (when available), and integration with OpenShift observability.

Includes live web console demos, guided exercises (enable Lightspeed → ask questions → generate YAML → troubleshoot a sample issue), verification steps (response accuracy, privacy settings), troubleshooting tips, and best practices for team adoption in production OpenShift environments. Builds on existing OpenShift administration workflows for faster, more confident cluster management.

**Audience:** OpenShift cluster administrators, platform engineers, SREs, and DevOps teams managing OCP clusters; familiarity with the OpenShift web console and basic Kubernetes concepts recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift Container Platform 4.21+ cluster with cluster-admin privileges.  
* Logged in to the OpenShift web console as cluster-admin.  
* OpenShift Lightspeed operator installed/enabled (Technology Preview; admin enables via OperatorHub if not pre-installed).  
* A test namespace with sample workloads (e.g., Deployment \+ Service \+ Route) for troubleshooting demos.  
* Basic familiarity with the OpenShift console (Perspective switcher, Workloads, Networking, YAML editor).

**Duration:** 75–100 minutes, including hands-on labs (shorter due to console-focused nature).

**Format:** Slides/overview → Live web console demos → Guided hands-on console exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Enable and verify OpenShift Lightspeed in the web console.  
* Ask natural-language questions and receive accurate explanations or steps.  
* Generate and apply YAML suggestions for common resources.  
* Use Lightspeed for contextual troubleshooting and best-practice recommendations.

### Topic 1: Overview of OpenShift Lightspeed

**Goal:** Understand the assistant’s purpose, scope, and Technology Preview status.

**Core Concepts to Cover:**

* Why Lightspeed: reduce time spent searching docs, reading YAML, or debugging via natural-language help inside the console.  
* Key features: explain resources, generate/edit YAML, troubleshoot issues, suggest best practices.  
* Privacy & security: on-cluster inference (when enabled), no external data sharing, enterprise-grade controls.  
* Scope: covers most console views (Workloads, Networking, Storage, Operators, etc.).

### Topic 2: Enabling and Configuring Lightspeed

**Goal:** Activate the feature and verify it’s working.

**Core Concepts to Cover:**

* OperatorHub install: Search “OpenShift Lightspeed” → subscribe (Technology Preview channel).  
* Enable in console: Global settings or project-level toggle (admin rights required).  
* Verify: Lightspeed icon appears in console sidebar or resource pages; test simple query.  
* Hands-on: Install/enable operator → toggle on → confirm icon visible and responsive.

### Topic 3: Natural-Language Queries and Explanations

**Goal:** Experience real-time assistance for common admin tasks.

**Core Concepts to Cover:**

* Open Lightspeed panel (sidebar or resource context).  
* Ask: “Explain why this pod is in CrashLoopBackOff”, “What does this NetworkPolicy do?”, “How do I expose this service externally?”  
* Response types: plain English explanation, step-by-step fix, links to relevant docs.  
* Hands-on exercise: Create a broken Deployment (missing image pull secret) → ask Lightspeed to diagnose → apply suggested fix.

### Topic 4: YAML Generation and Editing

**Goal:** Use Lightspeed to create or modify resources faster.

**Core Concepts to Cover:**

* From empty YAML editor: type “Create a Deployment for nginx with 3 replicas” → accept suggestion.  
* Edit existing: highlight YAML → ask “Add a readiness probe” → insert generated snippet.  
* Best practices: Lightspeed suggests OpenShift-specific annotations, security contexts, resource requests.  
* Hands-on: Generate a Route \+ Service \+ Deployment from prompt → apply → verify in console.

### Topic 5: Troubleshooting and Best Practices

**Goal:** Leverage Lightspeed for real-world debugging and optimization.

**Core Concepts to Cover:**

* Common queries: “My PVC is stuck in Pending”, “How do I set resource limits?”, “Why is my operator degraded?”  
* Recommendations: security context constraints, pod disruption budgets, node affinity.  
* Enterprise controls: disable for sensitive namespaces, audit usage, on-cluster model (future).  
* Hands-on: Introduce a sample issue (e.g., OOMKilled pod) → ask Lightspeed → apply fix → verify resolution.

### Topic 6: Q\&A, Limitati2ons, and Roadmap

**Goal:** Set realistic expectations and discuss adoption.

**Core Concepts to Cover:**

* Current limitations: Technology Preview, cloud-hosted inference (on-cluster coming), occasional hallucination (verify suggestions).  
* Roadmap: deeper OpenShift knowledge, multi-modal support, tighter RHDH integration.  
* Discussion: How would Lightspeed change your daily OpenShift management? What console tasks do you want it to help with most?

## Red Hat Developer Lightspeed – AI-Powered Code Assistance for Developers

**Description:**  
Accelerate everyday coding tasks with Red Hat Developer Lightspeed — the enterprise-grade AI coding assistant built for developers using Red Hat technologies. This hands-on session introduces how Lightspeed provides context-aware code completions, full-function generation, code explanations, refactoring suggestions, and natural-language chat directly in VS Code (and soon other IDEs), all while respecting data privacy, security, and Red Hat ecosystem alignment.

You'll learn to:

* Install and configure the Lightspeed VS Code extension.  
* Use inline completions and multi-line suggestions for Red Hat-specific patterns (e.g., Quarkus, Spring Boot on OpenShift).  
* Leverage chat for code explanation, debugging help, and unit test generation.  
* Apply refactoring and documentation suggestions in real projects.  
* Understand enterprise controls: data privacy (no training on your code), on-prem options, and integration with Red Hat Developer Hub (RHDH).

Includes live VS Code demos, guided exercises (install → code with Lightspeed → refactor a sample app), verification steps (acceptance rates, chat accuracy), troubleshooting tips, and best practices for team adoption in regulated environments. Builds on existing developer workflows for faster, higher-quality code with Red Hat technologies.  
**Audience:** Software developers, full-stack engineers, and DevOps practitioners using VS Code or RHEL; familiarity with Red Hat stacks (Quarkus, Spring Boot, OpenShift) is helpful but not required.

**Prerequisites (cover upfront):**

* A laptop with VS Code installed (v1.85+ recommended).  
* Internet access during setup (for extension install and initial model download).  
* Optional but recommended: Red Hat Developer Sandbox or personal Red Hat account (for full features and telemetry opt-in).  
* A small sample project (e.g., Quarkus quickstart or Spring Boot REST app) cloned from GitHub.  
* Basic familiarity with VS Code (Command Palette, terminal).

**Duration:** 75–100 minutes, including hands-on labs (shorter setup-focused session).  
**Format:** Slides/overview → Live VS Code demos → Guided hands-on extension exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Install and authenticate the Red Hat Developer Lightspeed extension in VS Code.  
* Use inline completions and chat for faster coding, debugging, and refactoring.  
* Generate tests, documentation, and explanations tailored to Red Hat technologies.  
* Understand enterprise-grade privacy, security, and integration with Red Hat Developer Hub.

### Topic 1: Overview of Red Hat Developer Lightspeed

**Goal:** Understand the tool’s purpose, architecture, and differentiation.

**Core Concepts to Cover:**

* Why Lightspeed: context-aware AI assistance built for Red Hat ecosystem (Quarkus, Spring Boot, OpenShift, RHEL).  
* Key features: inline completions, multi-line suggestions, chat (explain/refactor/test), documentation generation.  
* Privacy & security: no training on your code, enterprise controls, on-prem deployment options.  
* Integration: VS Code today, broader IDE/RHEL support coming.

### Topic 2: Installing and Configuring the Extension

**Goal:** Get Lightspeed running in under 5 minutes.

**Core Concepts to Cover:**

* VS Code Marketplace install → search “Red Hat Developer Lightspeed”.  
* Authentication: Red Hat SSO login or Developer Sandbox credentials.  
* Settings: enable/disable telemetry, choose model (cloud-hosted or on-prem when available), language preferences.  
* Hands-on: Install extension → sign in → verify status bar indicator (green when ready).

### Topic 3: Inline Completions & Multi-line Suggestions

**Goal:** Experience real-time coding acceleration.

**Core Concepts to Cover:**

* Trigger: type → Tab to accept, Ctrl+Right for alternatives.  
* Context awareness: recognizes project structure, Red Hat annotations, OpenShift YAML.  
* Use cases: REST controllers in Quarkus/Spring, OpenShift manifests, Dockerfile snippets.  
* Hands-on exercise: Clone Quarkus quickstart → write a REST endpoint → accept Lightspeed suggestion → compare time vs. manual coding.

### Topic 4: Chat for Explanation, Refactoring, and Tests

**Goal:** Use conversational AI for deeper assistance.

**Core Concepts to Cover:**

* Open chat panel (Ctrl+Shift+L or sidebar icon).  
* Ask: “Explain this Quarkus @GET method”, “Generate JUnit tests”, “Refactor to use Panache”.  
* Apply suggestions: one-click insert or copy-paste.  
* Hands-on: Open sample code → ask Lightspeed to explain a complex method → generate unit tests → apply and run.

### Topic 5: Enterprise Considerations & Best Practices

**Goal:** Understand governance, privacy, and team rollout.

**Core Concepts to Cover:**

* Data privacy: prompts/responses not used for training.  
* Integration with Red Hat Developer Hub (RHDH) → centralized plugin management.  
* On-prem future: self-hosted models for strict compliance.  
* Best practices: start with completions → move to chat → monitor acceptance rate in VS Code telemetry.  
* Hands-on: Toggle telemetry/settings → discuss team adoption (enable for juniors, opt-out for seniors).

### Topic 6: Q\&A, Limitations, and Roadmap

**Goal:** Address questions and set expectations.

**Core Concepts to Cover:**

* Current limitations: cloud-hosted only (on-prem coming), occasional hallucination (use as suggestion, not gospel).  
* Roadmap: broader IDE support, deeper Red Hat stack knowledge, RHDH integration.  
* Discussion: How would Lightspeed fit your current development workflow? What Red Hat technologies do you want it to know better?

## Models-as-a-Service (MaaS) in Red Hat OpenShift AI

**Description:**  
Explore the Developer Preview of Models-as-a-Service (MaaS) in Red Hat OpenShift AI Self-Managed 3.2 — a centralized approach to address resource consumption and governance challenges when serving large language models (LLMs). This session introduces how MaaS exposes models through managed API endpoints, enabling administrators to enforce policies across teams while making models globally discoverable via AI Available Assets in GenAI Studio.

You'll learn to:

* Understand MaaS core capabilities: policy & quota management, authentication/authorization, usage tracking, and user management.  
* Enable MaaS on model deployments and mark models as global services.  
* Configure metadata fields (Use Case, Description, Add to AI Assets) for automatic publishing to AI Available Assets.  
* Consume MaaS models cluster-wide from the GenAI Studio → AI Available Assets page.  
* Recognize current Developer Preview limitations and future direction.

Includes live dashboard walkthroughs, guided UI configuration examples, verification steps, and discussion of governance use cases. Builds on model serving and deployment sessions for enterprise-scale LLM management.  
**Audience:** Cluster administrators, MLOps leads, and governance/compliance teams managing shared LLM resources at scale; familiarity with model deployments and OpenShift AI dashboard recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard as a cluster admin.  
* Model serving platform enabled with at least one deployed model (for MaaS toggle demo).  
* Basic familiarity with model deployments and GenAI Studio.

**Duration:** 60–75 minutes, including live demos and discussion (presentation-focused; light hands-on configuration).  
**Format:** Slides/overview → Live dashboard demos → Guided configuration walkthroughs → Q\&A/discussion.

**Key Outcomes:** Participants should leave able to:

* Explain MaaS value in controlling LLM resource usage and governance.  
* Enable MaaS on deployments and configure global visibility.  
* Add metadata to make models discoverable in AI Available Assets.  
* Describe current Developer Preview capabilities and limitations.

### Topic 1: Overview of MaaS and Governance Challenges

**Goal:** Understand why MaaS exists and its Developer Preview status.

**Core Concepts to Cover:**

* Challenges: uncontrolled LLM deployments → high resource consumption, lack of visibility, governance gaps.  
* MaaS solution: centralized managed API endpoints with policy enforcement.  
* Current capabilities (Developer Preview): policy/quota management, auth/authorization, usage tracking, user management.  
* Status: not production-ready; features subject to change.

### Topic 2: Enabling and Configuring MaaS

**Goal:** See how administrators activate MaaS and make models global.

**Core Concepts to Cover:**

* Toggle in Model Deployments page → marks model as a managed service.  
* Global scope: visible/usable across all projects in the cluster.  
* Integration: automatically appears in GenAI Studio → AI Available Assets.  
* Demo: Enable toggle on a deployed model → verify global visibility.

### Topic 3: Metadata for AI Available Assets Integration

**Goal:** Configure discoverability and context for shared models.

**Core Concepts to Cover:**

* New fields in model deployment form:  
  * Use Case (free-form text) — e.g., "Customer Churn Prediction"  
  * Description (free-form text) — detailed functionality notes  
  * Add to AI Assets (checkbox) — auto-publishes with metadata  
* Result: models listed cluster-wide in AI Available Assets for easy discovery/consumption.  
* Demo: Add metadata → enable checkbox → view in GenAI Studio.

### Topic 4: Consuming MaaS Models from AI Available Assets

**Goal:** Experience end-user access to managed models.

**Core Concepts to Cover:**

* GenAI Studio → AI Available Assets page: browse global MaaS models.  
* Direct consumption: chat/completions via managed endpoints.  
* Benefits: no per-project redeployment, governed access, tracked usage.  
* Demo: Switch to non-admin view → discover and test a MaaS model.

### Topic 5: Limitations, Roadmap, and Best Practices

**Goal:** Set realistic expectations and discuss governance strategy.

**Core Concepts to Cover:**

* Developer Preview limitations: incomplete policy granularity, potential API changes, no production SLA.  
* Future direction: deeper quota controls, advanced usage analytics, integration with external API management.  
* Best practices: start with high-value shared models, combine with KServe runtimes, monitor via dashboard metrics.  
* Discussion: How would MaaS fit your current LLM governance needs?

# Administrators {#administrators}

# Section 1: Managing Administration Tasks from the OpenShift AI Dashboard

**Duration:** 75-100 minutes total

**Prerequisites verified before starting:**

- Each student has their own OpenShift cluster with RHOAI 3.2 installed
- Student is logged in as a cluster admin (kubeadmin or equivalent)
- A GPU node (g6e.4xlarge) is provisioned and the NVIDIA GPU Operator is running
- The Section 1 prep playbook has been run, creating the `sample-project` namespace with a running `sample-workbench` Notebook
- Student has both the OpenShift AI dashboard and the OpenShift web console open in browser tabs
- The `oc` CLI is installed and authenticated as cluster admin

**Instructor: before beginning,** confirm all students can reach their OpenShift AI dashboard. Have them navigate to their cluster's URL and verify they see the dashboard landing page. If anyone sees an authentication error, resolve it now -- everything in this section depends on dashboard access.

---

## Topic 1: Overview of Dashboard Administration and User Access

**Duration:** 15-20 minutes

### Instructor Notes

This topic establishes the mental model for the rest of the section. Students need to understand three things: (1) the OpenShift AI dashboard is the primary admin interface, not the OpenShift web console; (2) the **Settings** menu is where most admin work happens; and (3) access control is group-based, not user-based.

Start by walking through the dashboard layout. Point out the left navigation: **Applications**, **Data Science Projects**, **Data Science Pipelines**, **Distributed Workload Metrics**, **Model Serving**, and at the bottom, **Settings**. Emphasize that the **Settings** menu only appears for users who are cluster-admin or members of the admin group. This is the first clue that group membership controls what users see.

Explain the three main sub-menus under **Settings**:

- **User management** -- controls who can access the dashboard and who gets admin rights
- **Cluster settings** -- cluster-wide policies (timeouts, PVC defaults, model serving, telemetry)
- **Environment setup** -- workbench images, connection types, and other environment configuration

Explain the default access model: when RHOAI is first installed, all authenticated OpenShift users can access the dashboard and create data science projects. There are no restrictions. This is fine for small teams but becomes a problem at scale. The solution is group-based access control using two special groups:

- **rhods-admins** -- members see the Settings menu and can manage the platform
- **rhods-users** -- members can use the platform (create projects, workbenches, etc.)

When you assign specific groups to either role, only members of those groups get access. Everyone else is locked out. This is an important distinction: assigning groups is a restriction, not an expansion.

### Student Exercise: Explore the Settings Menu and Configure User Groups

**Step 1: Open the Settings menu.**

In the OpenShift AI dashboard, click **Settings** in the left navigation. You should see three sub-menus: **User management**, **Cluster settings**, and **Environment setup**. Click through each one briefly to get oriented.

**Step 2: Examine the current User management configuration.**

Navigate to **Settings > User management**. You should see two sections:

- **Data science administrator groups** -- controls who gets admin access
- **Data science user groups** -- controls who gets user access

By default, both should show "All OpenShift users" or have no specific groups assigned. Note the current state before making changes.

**Step 3: View available groups from the CLI.**

Open a terminal and list the existing OpenShift groups:

```bash
oc get groups
```

If no custom groups exist yet, you may see an empty list or only system groups. That is expected on a fresh cluster.

**Step 4: Create test groups.**

Create two groups that we will use for access control:

```bash
oc adm groups new rhods-admins
oc adm groups new rhods-users
```

> **Note:** If the groups already exist, you will see an `AlreadyExists` error. That is expected -- proceed to the next step.

Add your admin user (typically your HTPasswd username from the cluster auth setup) to the admins group:

> **Note on `kube:admin`:** The username `kube:admin` contains a colon, which causes validation errors when adding it to groups. Use your HTPasswd username instead. If you must use `kube:admin`, the encoded form `b64:kube:admin` may work, but the preferred approach is to use your HTPasswd identity.

```bash
oc adm groups add-users rhods-admins <your-username>
```

Verify the groups were created:

```bash
oc get groups
```

Expected output:

```
NAME            USERS
rhods-admins    <your-username>
rhods-users
```

**Step 5: Assign groups in the dashboard.**

Return to **Settings > User management**. Under **Data science administrator groups**, click the dropdown and select **rhods-admins**. Under **Data science user groups**, select **rhods-users**.

Click **Save changes**.

**Step 6: Verify the configuration.**

After saving, the dashboard should still be fully accessible to you because your user is in the `rhods-admins` group. If you were to log in as a user who is not in either group, that user would not see the dashboard at all.

To confirm the settings took effect, check the underlying configuration:

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications -o jsonpath='{.spec.groupsConfig}' | python3 -m json.tool
```

Expected output (approximately):

```json
{
    "adminGroups": "rhods-admins",
    "allowedGroups": "rhods-users"
}
```

> **RHOAI 3.2 Auth CR migration:** In RHOAI 3.2, group configuration has migrated from `OdhDashboardConfig.spec.groupsConfig` to a separate `Auth` custom resource (`services.platform.opendatahub.io/v1alpha1`). The first patch to `groupsConfig` may succeed as a one-time migration, but subsequent patches will fail with an error pointing to the Auth resource. If the command above returns empty or an error, verify the groups through the Auth CR instead:
>
> ```bash
> oc get auth auth -n redhat-ods-applications -o yaml
> ```
>
> Look for `spec.adminGroups` and `spec.allowedGroups` in the output.

**Step 7: Restore open access.**

For the remaining exercises, we want all users to have access. Go back to **Settings > User management** and clear the group selections so it returns to the default (all authenticated users). Click **Save changes**.

### Troubleshooting

- **Settings menu missing after assigning groups:** If you accidentally removed yourself from the admin group before saving, you have locked yourself out of the admin UI. In RHOAI 3.2, group configuration is managed through the `Auth` CR. Fix this from the CLI:

  ```bash
  oc patch auth auth -n redhat-ods-applications \
    --type merge -p '{"spec":{"adminGroups":["system:authenticated"],"allowedGroups":["system:authenticated"]}}'
  ```

  If the Auth CR does not exist on your cluster (older RHOAI versions), fall back to patching the dashboard config:

  ```bash
  oc patch odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
    --type merge -p '{"spec":{"groupsConfig":{"adminGroups":"system:authenticated","allowedGroups":"system:authenticated"}}}'
  ```

  Then refresh the dashboard.

- **Groups not appearing in the dropdown:** The dashboard reads groups from the OpenShift OAuth system. If a group was just created, wait a few seconds and refresh the page. If it still does not appear, verify with `oc get groups` that it exists.

---

## Topic 2: Customizing the Dashboard and Importing Images

**Duration:** 15-20 minutes

### Instructor Notes

This topic covers two related areas: configuring the dashboard's behavior through the `OdhDashboardConfig` custom resource, and importing custom workbench images that data scientists can use when creating workbenches.

Start by explaining `OdhDashboardConfig`. This is the central CR that controls what features are visible and enabled in the dashboard. It lives in the `redhat-ods-applications` namespace and is named `odh-dashboard-config`. While many settings are exposed through the Settings UI, some advanced options (like hiding specific menu items or disabling Tech Preview features) require editing this CR directly.

Show the students how to view the current configuration:

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications -o yaml
```

Point out key fields in the `spec` section: `dashboardConfig` contains boolean flags like `disableDistributedWorkloads`, `disableModelServing`, `disableFineTuning`, etc. Changing these hides or shows entire sections of the dashboard. Emphasize that this is a powerful tool for simplifying the UI for teams that only need a subset of features.

Then transition to importing custom workbench images. Explain that RHOAI ships with several built-in notebook images (Standard Data Science, PyTorch, TensorFlow, etc.), but organizations often need custom images with specific libraries, tools, or accelerator support. The dashboard provides a UI for importing these without writing YAML.

The image we will import is an InstructLab workbench with code-server (VS Code in the browser) and CUDA support: `quay.io/rh-aiservices-bu/instructlab-workbench-code-server-cuda:0.21.0`. This is a real-world example of a custom image that bundles a specialized IDE with GPU libraries.

### Student Exercise: Explore the Dashboard Config and Import a Custom Image

**Step 1: View the current dashboard configuration.**

From the CLI, examine the dashboard config:

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  -o jsonpath='{.spec.dashboardConfig}' | python3 -m json.tool
```

Review the output. Note which features are enabled and disabled. Common fields include:

- `disableModelServing` -- hides the model serving UI
- `disableDistributedWorkloads` -- hides distributed workload metrics
- `disablePipelines` -- hides the pipelines section
- `enablement` -- controls whether users can add ISV applications

> **Note:** On a fresh installation, you may see only a few fields. Fields like `disableModelServing` or `disableDistributedWorkloads` appear only after being explicitly set (either through the dashboard UI or a CLI patch). Their absence means the default value is in effect.

You do not need to change any of these now. This is for awareness -- you will use this in production to tailor the dashboard for your teams.

**Step 2: Navigate to the workbench images settings.**

In the dashboard, go to **Settings > Environment setup > Workbench images**.

You should see a list of built-in images (Standard Data Science, CUDA, PyTorch, TensorFlow, etc.) with toggle switches to enable or disable each one. These are the images that appear in the **Image selection** dropdown when a user creates a new workbench.

**Step 3: Import the InstructLab code-server image.**

Click the **Import new image** button. Fill in the form:

| Field | Value |
|---|---|
| **Image location** | `quay.io/rh-aiservices-bu/instructlab-workbench-code-server-cuda:0.21.0` |
| **Name** | `InstructLab Code Server` |
| **Description** | `InstructLab workbench with VS Code (code-server) and CUDA support for GPU-accelerated model customization` |

Under **Accelerator identifier**, if your cluster has a GPU node with the NVIDIA GPU Operator running, you can optionally add:

- Click **Add accelerator** (or the accelerator association field, if present)
- Enter `nvidia.com/gpu` as the accelerator identifier

This tells RHOAI that this image is designed to work with NVIDIA GPUs and will show the appropriate hardware profile options when a user selects this image.

Click **Import**.

**Step 4: Verify the imported image appears.**

After import, the image should appear in the **Workbench images** list with the name **InstructLab Code Server** and a green toggle indicating it is enabled.

Verify from the CLI that an ImageStream was created:

```bash
oc get imagestreams -n redhat-ods-applications | grep -i instructlab
```

Expected output (similar to):

```
instructlab-code-server   quay.io/rh-aiservices-bu/instructlab-workbench-code-server-cuda   0.21.0   ...
```

**Step 5: Confirm the image is available in workbench creation.**

Navigate to **Data Science Projects** and click into any project (or create a temporary one). Click **Create workbench**. In the **Image selection** dropdown, scroll down to find **InstructLab Code Server**. It should appear alongside the built-in images.

You do not need to actually create a workbench -- just confirm the image is selectable. Click **Cancel** to exit the form.

**Step 6 (Optional): Examine the OdhDashboardConfig for advanced customization.**

For instructors who want to demonstrate advanced config, you can briefly show how to disable a feature. For example, to hide the Distributed Workload Metrics section:

```bash
oc patch odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  --type merge -p '{"spec":{"dashboardConfig":{"disableDistributedWorkloads":true}}}'
```

Refresh the dashboard. The **Distributed Workload Metrics** item should disappear from the left navigation. Re-enable it:

```bash
oc patch odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  --type merge -p '{"spec":{"dashboardConfig":{"disableDistributedWorkloads":false}}}'
```

This demonstrates the power of the `OdhDashboardConfig` CR for tailoring the user experience without changing any code.

### Troubleshooting

- **Image import fails with "unable to pull" error:** The dashboard validates the image URL during import. Ensure the image is publicly accessible or that a pull secret for the registry is configured on the cluster. For `quay.io` public images, no pull secret is needed.

- **Image does not appear in workbench creation dropdown:** The image may take a minute to propagate. Refresh the page. Also verify the image toggle is set to **Enabled** in **Settings > Environment setup > Workbench images**.

- **Accelerator association not available:** If the accelerator identifier field does not appear during import, you can associate the accelerator after import by clicking the image name in the Workbench images list and editing its details.

---

## Topic 3: Managing Storage Resources (PVC, Classes, Connections)

**Duration:** 15-20 minutes

### Instructor Notes

This topic covers three related storage and connectivity concepts that admins manage through the dashboard: default PVC sizes, storage class configuration, and connection types.

Start with PVC sizes. When a user creates a workbench or adds cluster storage to a project, the default storage size is 20 GiB. Admins can change this default to match their organization's needs. Explain that this only affects new PVCs -- existing ones are not resized. Also note that very large defaults can waste storage quota.

Then cover storage classes. OpenShift clusters typically have one or more storage classes (e.g., `gp3-csi` on AWS). RHOAI lets admins control which storage classes are visible to users in the dashboard and set display names, descriptions, and access modes. This is important because not all storage classes are appropriate for data science workloads -- for example, some may not support the access mode needed for shared workbenches.

Finally, cover connection types. Connections are how workbenches access external resources like S3 buckets, databases, or model registries. RHOAI ships with several pre-installed connection types (S3-compatible storage, URI, etc.). Admins can create custom connection types for organization-specific integrations. Connection types define the form fields that users fill in when creating a connection, so this is also a UX design exercise.

### Student Exercise: Configure PVC Defaults, Storage Classes, and Connection Types

**Step 1: View and adjust the default PVC size.**

Navigate to **Settings > Cluster settings**. Scroll to the **PVC size** section (labeled **Notebook PVC size** or **Default PVC size**).

Note the current default value (should be 20 GiB). Change it to **25 GiB** using the input field.

Click **Save changes**.

Verify from the CLI:

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  -o jsonpath='{.spec.notebookController.pvcSize}' && echo
```

Expected output:

```
25Gi
```

Now change it back to the default:

Set the value back to **20 GiB** in the dashboard and save. This confirms you can adjust and restore the setting.

**Step 2: Explore storage class settings.**

In **Settings > Cluster settings**, scroll to the **Storage classes** section. You should see the storage classes available on your cluster.

For an AWS-based cluster, you will likely see `gp3-csi` (or `gp2-csi`). Each storage class entry shows:

- **Enable/Disable toggle** -- controls whether this class appears in the dashboard
- **Display name** -- what users see
- **Description** -- optional help text
- **Access mode** -- RWO (ReadWriteOnce) or RWX (ReadWriteMany)

Note the default settings. If `gp3-csi` is present, click on it to expand its details and note the access mode. AWS EBS-backed classes typically support only RWO (a single node can mount the volume). RWX requires a shared filesystem like EFS or CephFS.

**Instructor note:** If your cluster has an additional storage class (e.g., `efs-sc` for AWS EFS), demonstrate enabling it and discuss when RWX is useful (shared data across multiple workbenches). If not, simply explain the concept. Do not enable RWX on a storage class that does not support it -- this will cause PVC binding failures.

**Step 3: Explore connection types.**

Navigate to **Settings > Environment setup > Connection types**. You should see several pre-installed connection types:

- **S3 compatible object storage** -- for S3/MinIO connections
- **URI** -- for generic URL-based connections
- **OCI compliant registry** -- for container/model registries

Click on **S3 compatible object storage** to view its details. Note the fields it defines: Access Key, Secret Key, Endpoint, Bucket, Region, etc. These fields become the form that users fill in when creating a connection of this type in their data science project.

**Step 4: Create a custom connection type.**

Click **Create connection type**. This opens a form builder where you define a new connection template.

Fill in the following:

| Field | Value |
|---|---|
| **Category** | Select **Object storage** (or create a new category) |
| **Name** | `Workshop Demo Connection` |
| **Description** | `A demonstration connection type for the workshop` |
| **Enable** | Toggle on |

Now add fields that users will see when creating this connection type. Click **Add field** and create these fields:

1. **Field name:** `API Endpoint`; **Type:** `Short text`; **Required:** Yes
2. **Field name:** `API Key`; **Type:** `Hidden` (password field); **Required:** Yes
3. **Field name:** `Project ID`; **Type:** `Short text`; **Required:** No

Click **Preview** to see what the connection form will look like to users. This preview shows the exact form that appears when a user creates a connection of this type.

Click **Create** to save the connection type.

**Step 5: Verify the new connection type.**

Navigate to any data science project. Click **Add connection** (or go to the connections tab). In the **Connection type** dropdown, you should see **Workshop Demo Connection** alongside the pre-installed types.

You do not need to actually create a connection -- just confirm the type is available. Click **Cancel** to exit.

**Step 6: Clean up the demo connection type.**

Return to **Settings > Environment setup > Connection types**. Find **Workshop Demo Connection**, click the kebab menu (three dots), and select **Delete**. Confirm the deletion.

### Troubleshooting

- **PVC size change not reflected in new workbenches:** The default PVC size applies at workbench creation time. If a workbench was created before the change, its existing PVC retains the old size. Only newly created workbenches pick up the new default.

- **Storage class toggle grayed out:** The default storage class cannot be disabled through the dashboard. If you need to change which class is default, do so from the OpenShift web console or CLI:

  ```bash
  oc annotate storageclass gp3-csi storageclass.kubernetes.io/is-default-class=true --overwrite
  ```

- **Custom connection type not appearing in projects:** Ensure the toggle is set to **Enabled** when creating the connection type. Disabled types do not appear in the connection creation form.

---

## Topic 4: Administering Workbenches and Cluster Policies

**Duration:** 15-20 minutes

### Instructor Notes

This topic brings together workbench lifecycle management and cluster-wide policies. The Section 1 prep playbook has already created a `sample-project` namespace with a running `sample-workbench` Notebook, so students have something concrete to manage.

Start by explaining the admin view of workbenches. When a user with admin rights opens the dashboard, they can see workbenches across all projects, not just their own. This is critical for operations -- an admin may need to stop a runaway workbench consuming excessive GPU resources, or restart a workbench that has gotten into a bad state.

Then cover idle workbench timeout. This is the most impactful cluster policy for cost management. GPU workbenches are expensive, and users often forget to stop them. The idle timeout automatically stops workbenches after a period of inactivity (no kernel activity, no terminal commands). The default is no timeout, meaning workbenches run indefinitely.

Finally, cover tolerations. In Kubernetes, nodes can be "tainted" to repel pods that don't explicitly tolerate the taint. This is commonly used with GPU nodes -- you taint the GPU nodes so that only workloads that need GPUs (and declare a toleration) get scheduled there. RHOAI provides a dashboard setting to add tolerations to all notebook pods, which is simpler than requiring users to configure tolerations manually.

### Student Exercise: Manage Workbenches and Configure Cluster Policies

**Step 1: Verify the sample workbench is running.**

From the CLI, confirm that the prep playbook's workbench is up:

```bash
oc get notebooks -n sample-project
```

Expected output:

```
NAME               AGE
sample-workbench   ...
```

> **Note:** In RHOAI 3.2, the Notebook CRD does not include a `READY` printer column. You will see only `NAME` and `AGE` in the output. To check readiness, inspect the pod status instead.

Also check the pod:

```bash
oc get pods -n sample-project -l app=sample-workbench
```

You should see a pod in `Running` status.

**Step 2: Access the workbench administration view.**

In the OpenShift AI dashboard, navigate to **Data Science Projects**. You should see **sample-project** in the project list. Click into it.

Under the **Workbenches** tab, you should see **sample-workbench** with a green status indicator showing it is running.

As a cluster admin, you have full control over this workbench even though it may have been created by a different user or automation.

**Step 3: Stop the sample workbench from the dashboard.**

Click the toggle switch next to the **sample-workbench** status to stop it. A confirmation dialog may appear. Confirm the action.

The status should change from **Running** to **Stopped**. This may take 15-30 seconds.

Verify from the CLI:

```bash
oc get pods -n sample-project -l app=sample-workbench
```

Expected output: No pods running (or a pod in `Terminating` state).

Also check the Notebook resource status:

```bash
oc get notebooks sample-workbench -n sample-project -o jsonpath='{.metadata.annotations.kubeflow-resource-stopped}' && echo
```

If the workbench was stopped through the dashboard, this annotation will contain a timestamp indicating when it was stopped.

**Step 4: Restart the workbench.**

Click the toggle switch again to restart the workbench. Wait for the status to return to **Running** (this may take 1-2 minutes as the pod starts and passes readiness probes).

Verify:

```bash
oc get pods -n sample-project -l app=sample-workbench
```

Expected output: A pod in `Running` status with `1/1` containers ready.

**Step 5: Configure idle workbench timeout.**

Navigate to **Settings > Cluster settings**. Scroll to the **Stop idle notebooks** section (may also be labeled **Idle workbench timeout**).

Enable the idle timeout toggle and set the value to **30 minutes**. This means any workbench with no activity for 30 minutes will be automatically stopped.

Click **Save changes**.

Verify the setting from the CLI:

```bash
oc get configmap notebook-controller-culler-config -n redhat-ods-applications \
  -o jsonpath='{.data}' && echo
```

> **Note:** In RHOAI 3.2, this ConfigMap may not exist. The idle timeout may be managed entirely through the `OdhDashboardConfig` CR or the `notebook-controller-config` ConfigMap. If the command above returns a `NotFound` error, use the fallback command below instead -- it is the reliable approach across versions.

If the ConfigMap does not exist, check the dashboard config CR directly:

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  -o jsonpath='{.spec.notebookController}' && echo
```

**Instructor note:** The idle timeout mechanism works by monitoring kernel activity in Jupyter-based workbenches. Active kernels (running code, training models) prevent the timeout from triggering. However, an open browser tab alone does not count as activity. Explain this distinction clearly -- users sometimes expect that having the tab open keeps the workbench alive.

**Step 6: Add a toleration for GPU-tainted nodes.**

Navigate to **Settings > Cluster settings**. Scroll to the **Tolerations** section (may be labeled **Notebook pod tolerations**).

Click **Add toleration** and enter:

| Field | Value |
|---|---|
| **Key** | `nvidia.com/gpu` |
| **Operator** | `Exists` |
| **Effect** | `NoSchedule` |

Click **Save changes**.

This toleration will be added to all new notebook pods, allowing them to be scheduled on GPU-tainted nodes. Existing running workbenches are not affected -- only workbenches started after this change.

Verify the setting:

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  -o jsonpath='{.spec.notebookController.notebookTolerationSettings}' | python3 -m json.tool
```

> **Note:** If tolerations have not been configured yet, the jsonpath returns empty output, which causes `python3 -m json.tool` to fail with a parse error. This is harmless -- it just means no custom tolerations are set. You can omit the `| python3 -m json.tool` pipe to see the raw (possibly empty) output.

**Step 7: Verify the toleration in a running pod (optional).**

If you want to confirm tolerations are applied to notebook pods, restart the sample workbench (stop and start it via the dashboard), then inspect the pod:

```bash
oc get pod -n sample-project -l app=sample-workbench -o jsonpath='{.items[0].spec.tolerations}' | python3 -m json.tool
```

Look for the `nvidia.com/gpu` toleration in the output alongside the default Kubernetes tolerations.

### Troubleshooting

- **Workbench stuck in "Starting" state:** This usually means the pod cannot pull the image or cannot schedule (resource constraints). Check pod events:

  ```bash
  oc describe pod -n sample-project -l app=sample-workbench
  ```

  Look at the **Events** section at the bottom for error messages about image pulls, resource limits, or scheduling failures.

- **Idle timeout not stopping workbenches:** The culler runs on an interval and checks for activity. It may take slightly longer than the configured timeout to actually stop a workbench. Also note that workbenches with active kernel computations (even background ones) are not considered idle.

- **Toleration not appearing on new pods:** Ensure you saved the changes in **Settings > Cluster settings**. The toleration is injected by the notebook controller at pod creation time, so only workbenches started after the change will have it. Pre-existing running workbenches must be restarted.

- **sample-workbench not found:** If the prep playbook was not run or failed, you can manually create the workbench resources. The manifest is at `exercises/sample-workbench.yaml` in the workshop repository:

  ```bash
  oc apply -f exercises/sample-workbench.yaml
  ```

  Wait 2-3 minutes for the workbench pod to reach `Running` state.

---

## Topic 5: Telemetry and Usage Data Collection

**Duration:** 5-10 minutes

### Instructor Notes

This is a short topic covering RHOAI's built-in telemetry. Keep it concise and factual. The key points are:

1. RHOAI collects anonymized usage data by default to help Red Hat improve the product.
2. The data includes metrics about which applications and features are used, deployment configurations, and image usage. It does not include personal data, notebook contents, model data, or connection credentials.
3. Data is sent to third-party analytics providers (Segment/equivalent).
4. Admins can disable this at any time with no impact on platform functionality.
5. Disconnected (air-gapped) environments have telemetry disabled by default since data cannot be sent.

The main reason to cover this is compliance. Organizations with strict data governance policies may require telemetry to be disabled. Students should know where the toggle is and what it controls.

### Student Exercise: Check and Toggle Telemetry Settings

**Step 1: View the current telemetry status.**

Navigate to **Settings > Cluster settings**. Scroll to the **Usage data collection** section (may also be labeled **Allow collection of usage data**).

Note whether the toggle is currently enabled or disabled. On a standard installation, it is enabled by default.

**Step 2: Examine the setting from the CLI.**

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  -o jsonpath='{.spec.dashboardConfig.disableTracking}' && echo
```

If the output is `false` or empty, telemetry is enabled. If `true`, telemetry is disabled.

**Step 3: Disable telemetry.**

Toggle the **Usage data collection** switch to **off** in the dashboard. Click **Save changes**.

Verify:

```bash
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  -o jsonpath='{.spec.dashboardConfig.disableTracking}' && echo
```

Expected output:

```
true
```

**Step 4: Re-enable telemetry.**

Toggle the switch back to **on** and save. This is the recommended default unless your organization's policy requires it to be off.

**Instructor note:** Emphasize that disabling telemetry has zero impact on platform functionality. No features are degraded or removed. The only consequence is that Red Hat receives less usage data, which is used for product improvement prioritization. For production environments, check with your organization's security and compliance team before making a decision.

### Troubleshooting

- **Toggle appears grayed out:** This should not happen for cluster admins. If it does, verify your user has admin access by checking **Settings > User management** or confirming your group membership with `oc get groups`.

---

## Section 1 Wrap-Up

**Instructor:** Spend 2-3 minutes summarizing what was covered:

1. The OpenShift AI dashboard's **Settings** menu is the central hub for admin operations. Most day-to-day administrative tasks do not require the OpenShift web console or CLI.

2. Group-based access control via **rhods-admins** and **rhods-users** controls who can see and do what. The dashboard becomes invisible to users outside the configured groups.

3. Custom workbench images can be imported directly through the dashboard UI. The `OdhDashboardConfig` CR provides advanced control over which features and UI elements are visible.

4. Storage defaults (PVC size, storage classes) and connection types are managed through **Cluster settings** and **Environment setup** respectively. These affect the experience for all users creating new resources.

5. Workbench lifecycle management (start/stop/idle timeout) and tolerations for tainted nodes are critical for cost management and GPU scheduling.

6. Telemetry is a simple toggle with no functional impact -- decide based on organizational policy.

**Transition to Section 2:** The next section covers deeper administrative tasks using the CLI and YAML manifests, including user and group management at the OpenShift level, accelerator configuration, Kueue for workload scheduling, and more. The dashboard UI work in this section is the foundation; Section 2 adds the programmatic layer.
---
## Managing OpenShift AI -- Admin Tasks for Users, Resources, Accelerators, and Workloads

**Duration:** 90-120 minutes

**Description:**
As a cluster administrator, gain hands-on expertise in managing Red Hat OpenShift AI Self-Managed 3.2 at scale. This session covers essential admin operations to control access, customize environments, optimize hardware, enforce quotas on distributed workloads, integrate identity providers, and ensure data protection and observability.

**Audience:** Cluster administrators and DevOps engineers supporting data science/ML teams.

**Prerequisites (covered in Section 1 and prep playbook):**

- Each student has their own OpenShift cluster with RHOAI 3.2 installed
- `oc` CLI installed and authenticated as cluster admin
- GPU node (g6e.4xlarge) running with NFD + GPU Operator + ClusterPolicy applied
- The `my-project` namespace exists (created by prep playbook)
- An NVIDIA GPU HardwareProfile is already applied (from `exercises/hardware-profile-nvidia-gpu.yaml`)

**Key Outcomes:** By the end of this section, participants will be able to:

- Configure users and groups for secure multi-tenancy
- Enable and import custom notebook images
- Customize the OpenShift AI dashboard
- Verify accelerator detection and HardwareProfile configuration
- Set up Kueue for quota management and distributed workload scheduling
- Understand OIDC integration, backup strategies, and monitoring concepts

---

### Topic 1: Managing Users and Groups (15-20 min)

**Instructor Notes:**

Start by explaining the default access model in OpenShift AI. The key point to drive home: by default, every authenticated OpenShift user gets access to the OpenShift AI dashboard. This is fine for small teams, but in production you almost always want to restrict access using groups. Walk through the concepts first, then have students do the exercise.

Explain these concepts before the hands-on portion:

- **Default access:** All authenticated OpenShift users get basic dashboard access. Cluster admins automatically get full admin rights.
- **Group-based restriction:** Create groups like `rhods-users` (standard users) and `rhods-admins` (admin users), then configure the dashboard to use those groups instead of allowing all authenticated users.
- **User lifecycle:** When removing a user, always stop their workbenches first, back up any PVCs they own, then remove them from groups and clean up their resources (PVCs, ConfigMaps, Secrets).
- **Best practice:** Integrate with your identity provider's group sync (e.g., LDAP group sync) rather than managing group membership manually in production.

**Student Exercise: Create Groups and Configure Access**

1. **Create the admin and user groups:**

   ```bash
   oc adm groups new rhods-admins
   oc adm groups new rhods-users
   ```

   Expected output for each:

   ```
   group.user.openshift.io/rhods-admins created
   group.user.openshift.io/rhods-users created
   ```

2. **Add your user to both groups** (since you are the admin for this cluster):

   ```bash
   # Find your username
   oc whoami

   # Add yourself to the admin group
   oc adm groups add-users rhods-admins $(oc whoami)

   # Add yourself to the user group as well
   oc adm groups add-users rhods-users $(oc whoami)
   ```

   > **Note:** If `oc whoami` returns `kube:admin`, the `oc adm groups add-users` command will fail because the colon is treated as a separator. In that case, use your htpasswd username instead (e.g., `admin`), or use the base64-encoded form: `oc adm groups add-users rhods-admins 'b64:kube:admin'`.

3. **Verify group membership:**

   ```bash
   oc get groups
   ```

   Expected output:

   ```
   NAME           USERS
   rhods-admins   <your-username>
   rhods-users    <your-username>
   ```

4. **Configure the dashboard to use these groups.** Open the OpenShift AI dashboard and navigate to **Settings --> User management**. You will see two fields:

   - **Data science administrator groups** -- set this to `rhods-admins`
   - **Data science user groups** -- set this to `rhods-users`

   Click **Save** after making changes.

   Alternatively, you can patch the `OdhDashboardConfig` directly:

   ```bash
   oc patch odhdashboardconfig odh-dashboard-config \
     -n redhat-ods-applications \
     --type merge \
     -p '{"spec":{"groupsConfig":{"adminGroups":"rhods-admins","allowedGroups":"rhods-users"}}}'
   ```

   > **Note (RHOAI 3.2):** In RHOAI 3.2, group configuration has migrated to the `Auth` custom resource. When you update groups through the dashboard UI, the changes are written to the `Auth` CR rather than `OdhDashboardConfig`. The `OdhDashboardConfig` patch above may still work for initial setup, but the `Auth` CR is the authoritative source. To patch groups via the `Auth` CR directly:
   >
   > ```bash
   > oc patch auth auth \
   >   --type merge \
   >   -p '{"spec":{"adminGroups":["rhods-admins"],"allowedGroups":["rhods-users"]}}'
   > ```

5. **Verify the change took effect:**

   First, check the `Auth` CR (the authoritative source in RHOAI 3.2):

   ```bash
   oc get auth auth -o yaml
   ```

   Look for the `adminGroups` and `allowedGroups` fields in the spec.

   You can also check the legacy `OdhDashboardConfig`:

   ```bash
   oc get odhdashboardconfig odh-dashboard-config \
     -n redhat-ods-applications \
     -o jsonpath='{.spec.groupsConfig}' | python3 -m json.tool
   ```

   Expected output:

   ```json
   {
       "adminGroups": "rhods-admins",
       "allowedGroups": "rhods-users"
   }
   ```

6. **Refresh the OpenShift AI dashboard** in your browser and confirm you still have access. If you removed yourself from the groups, you would lose access -- this is why we added ourselves to both groups first.

**Troubleshooting:**

- If you lock yourself out of the dashboard, you can always fix it via `oc` since you are a cluster admin. Patch the `Auth` CR to restore access: `oc patch auth auth --type merge -p '{"spec":{"allowedGroups":["system:authenticated"]}}'`. You can also patch the `OdhDashboardConfig` as a fallback.
- Group changes can take 30-60 seconds to propagate. Refresh the dashboard and wait if access does not change immediately.
- If group changes made via the dashboard UI do not appear in `OdhDashboardConfig`, check the `Auth` CR instead: `oc get auth auth -o yaml`. In RHOAI 3.2, this is the authoritative source for group configuration.

---

### Topic 2: Enabling Custom Images in OpenShift AI (10-15 min)

**Instructor Notes:**

Explain why custom images matter: the default notebook images cover common frameworks (PyTorch, TensorFlow, standard data science), but teams often need specific library versions, OS-level packages, or accelerator-specific tooling. Custom images let you provide those pre-built environments through the dashboard so data scientists can just select them.

Cover the compatibility requirements before the exercise:

- **Non-root execution:** The image must run as UID 1001 (not root). OpenShift enforces this.
- **Working directory:** Use `/opt/app-root/src` as the home/working directory.
- **Health probes:** The image should respond on `/api` endpoints for liveness/readiness probes.
- **Base images:** Building on top of existing RHOAI notebook images is the easiest way to ensure compatibility.

The image we will use is the InstructLab code-server with CUDA support:
`quay.io/rh-aiservices-bu/instructlab-workbench-code-server-cuda:0.21.0`

**Student Exercise: Import a Custom Image**

> **Note:** If you already imported this image in Section 1, skip to step 4 to verify it is still available. If you are starting fresh with this section, follow all steps.

1. **Open the OpenShift AI dashboard** and navigate to **Settings > Environment setup > Workbench images**.

2. **Click "Import new image"** and fill in:

   - **Image location:** `quay.io/rh-aiservices-bu/instructlab-workbench-code-server-cuda:0.21.0`
   - **Name:** `InstructLab Code Server`
   - **Description:** `InstructLab workbench with code-server IDE and CUDA GPU support`
   - **Software:** Add entries for `InstructLab` and `code-server`
   - **Packages:** Add entries for `CUDA` and `Python 3.11` (or whatever is relevant)

3. **Click Import.** The image should appear in the list of notebook images with its status showing as "Enabled".

4. **Verify the image is available.** Navigate to **Data Science Projects > my-project** and click **Create workbench**. In the **Notebook image** dropdown, you should see "InstructLab Code Server" as an option. Do not actually create a workbench -- just confirm the image appears in the list, then cancel.

5. **Verify via CLI** that the ImageStream was created:

   ```bash
   oc get imagestreams -n redhat-ods-applications | grep instructlab
   ```

   You should see an entry for the imported image.

   Look for the labels and annotations that make the image visible in the dashboard, including `opendatahub.io/notebook-image: "true"`.

**Troubleshooting:**

- If the image does not appear in the workbench creation dropdown, check that it shows as "Enabled" in **Settings --> Notebook images**. You can toggle it off and on.
- If the import fails with a pull error, the image may require authentication. For public images like the one in this exercise, no credentials are needed.
- The `BYON` label (Bring Your Own Notebook) is automatically applied by the dashboard when you import via the UI.

---

### Topic 3: Managing Applications in the Dashboard (15-20 min)

**Instructor Notes:**

The OpenShift AI dashboard is highly customizable through the `OdhDashboardConfig` custom resource. This topic is about controlling what users see and can do in the dashboard. Walk through the CR structure first, explaining that nearly every dashboard feature can be toggled via this single resource.

Key concepts to cover:

- The `OdhDashboardConfig` CR named `odh-dashboard-config` lives in the `redhat-ods-applications` namespace.
- It controls feature flags, component visibility, and user-facing settings.
- Applications can be added via `OdhApplication` CRs, but you can prevent users from adding their own.
- Hiding defaults (e.g., the Jupyter tile) is done by toggling specific flags.
- Info panels and ISV partner badges can be shown or hidden.

**Student Exercise: Explore and Modify OdhDashboardConfig**

1. **Examine the current dashboard configuration:**

   ```bash
   oc get odhdashboardconfig odh-dashboard-config \
     -n redhat-ods-applications -o yaml
   ```

   Take a moment to review the structure. The `spec` section contains feature flags like `dashboardConfig`, `notebookController`, and `groupsConfig`.

2. **Disable the ability for users to add applications.** This prevents non-admin users from adding ISV application tiles to the dashboard:

   ```bash
   oc patch odhdashboardconfig odh-dashboard-config \
     -n redhat-ods-applications \
     --type merge \
     -p '{"spec":{"dashboardConfig":{"enablement":false}}}'
   ```

3. **Refresh the dashboard** and verify. The "Explore" page should no longer show enable buttons for ISV applications to non-admin users.

4. **Toggle the notebook controller visibility.** This controls whether the basic workbench creation tile is visible:

   ```bash
   # Check current state
   oc get odhdashboardconfig odh-dashboard-config \
     -n redhat-ods-applications \
     -o jsonpath='{.spec.notebookController}' | python3 -m json.tool
   ```

5. **Experiment with disabling an info panel.** For example, to hide the "Getting Started" info resources:

   ```bash
   oc patch odhdashboardconfig odh-dashboard-config \
     -n redhat-ods-applications \
     --type merge \
     -p '{"spec":{"dashboardConfig":{"disableInfo":true}}}'
   ```

   Refresh the dashboard and observe the change. The info panel on the home page should disappear.

6. **Re-enable the info panel** (so the dashboard is back to normal for later exercises):

   ```bash
   oc patch odhdashboardconfig odh-dashboard-config \
     -n redhat-ods-applications \
     --type merge \
     -p '{"spec":{"dashboardConfig":{"disableInfo":false}}}'
   ```

7. **Review available OdhApplication CRs** to see what application tiles exist:

   ```bash
   oc get odhapplications -n redhat-ods-applications
   ```

   Each of these corresponds to a tile in the dashboard's Explore or Enabled pages.

**Troubleshooting:**

- Dashboard changes from `OdhDashboardConfig` patches are usually reflected within a few seconds after a browser refresh. If changes do not appear, try a hard refresh (Ctrl+Shift+R / Cmd+Shift+R).
- If you accidentally break the dashboard config, you can restore it by examining the operator's default values. The RHOAI operator will reconcile certain fields back to defaults if they are removed entirely.
- Be careful with `notebookController.enabled: false` in a real environment -- it hides the ability to create workbenches from the dashboard entirely.

---

### Topic 4: Custom Deployment Resources and Accelerators (15-20 min)

**Instructor Notes:**

The prep playbook has already created an NVIDIA GPU HardwareProfile and the GPU node is running. This topic is about verification and understanding rather than creation. Walk students through the full chain: physical hardware (GPU on the node) detected by NFD, managed by the GPU Operator, exposed via ClusterPolicy, and made selectable in the dashboard via a HardwareProfile.

Explain the HardwareProfile concept:

- HardwareProfiles replaced the older AcceleratorProfile mechanism in RHOAI 3.x
- They define what hardware resources are available and how they appear in the dashboard
- They can include GPU counts, node selectors, and tolerations
- The `infrastructure.opendatahub.io/v1` API version is specific to OpenShift AI

**Student Exercise: Verify GPU Detection and HardwareProfile**

1. **Find the GPU node and verify NVIDIA GPU capacity:**

   ```bash
   oc get nodes -l nvidia.com/gpu.present=true
   ```

   You should see one node (the g6e.4xlarge instance). Now inspect its GPU capacity:

   ```bash
   oc get nodes -l nvidia.com/gpu.present=true \
     -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}gpu-capacity: {.status.capacity.nvidia\.com/gpu}{"\t"}gpu-allocatable: {.status.allocatable.nvidia\.com/gpu}{"\n"}{end}'
   ```

   Expected output shows 1 allocatable GPU:

   ```
   ip-10-x-x-x.ec2.internal   gpu-capacity: 1   gpu-allocatable: 1
   ```

2. **Get detailed GPU information from the node labels:**

   ```bash
   oc get nodes -l nvidia.com/gpu.present=true \
     -o jsonpath='{range .items[*]}Node: {.metadata.name}{"\n"}  GPU Product: {.metadata.labels.nvidia\.com/gpu\.product}{"\n"}  GPU Memory: {.metadata.labels.nvidia\.com/gpu\.memory}{"\n"}  CUDA Driver: {.metadata.labels.nvidia\.com/cuda\.driver\.major}{"\n"}{end}'
   ```

3. **Verify the NVIDIA ClusterPolicy is ready:**

   ```bash
   oc get clusterpolicy gpu-cluster-policy -o jsonpath='{.status.state}'
   ```

   Expected output: `ready`

4. **Examine the HardwareProfile that the prep playbook created:**

   ```bash
   oc get hardwareprofile nvidia-gpu \
     -n redhat-ods-applications -o yaml
   ```

   Review the key fields in the output:

   ```yaml
   apiVersion: infrastructure.opendatahub.io/v1
   kind: HardwareProfile
   metadata:
     name: nvidia-gpu
     namespace: redhat-ods-applications
     labels:
       app.opendatahub.io/hardwareprofile: "true"
     annotations:
       opendatahub.io/display-name: "NVIDIA GPU"
       opendatahub.io/description: "NVIDIA GPU accelerator for AI/ML workloads"
       opendatahub.io/disabled: "false"
   spec:
     identifiers:
       - displayName: CPU
         identifier: cpu
         defaultCount: 2
         maxCount: 8
         minCount: 1
         resourceType: CPU
       - displayName: Memory
         identifier: memory
         defaultCount: 8Gi
         maxCount: 32Gi
         minCount: 2Gi
         resourceType: Memory
       - displayName: GPU
         identifier: nvidia.com/gpu
         defaultCount: 1
         maxCount: 1
         minCount: 1
         resourceType: Accelerator
     scheduling:
       type: Node
       node:
         tolerations:
           - key: nvidia.com/gpu
             operator: Exists
             effect: NoSchedule
   ```

   Key things to note:
   - The `app.opendatahub.io/hardwareprofile: "true"` label makes it visible in the dashboard
   - Display name and description are in annotations, not spec fields
   - The `identifier: nvidia.com/gpu` maps to the Kubernetes extended resource
   - The `scheduling.node.tolerations` allow pods to schedule onto GPU nodes with a `NoSchedule` taint
   - `maxCount: 1` matches the single GPU on our g6e.4xlarge node
   - CPU and memory identifiers let users customize resource requests within the defined ranges

5. **Verify the HardwareProfile appears in the dashboard.** Navigate to **Settings --> Hardware profiles** in the OpenShift AI dashboard. You should see "NVIDIA GPU" listed and enabled.

6. **Confirm the profile is selectable for workbenches.** Go to **Data Science Projects --> my-project --> Create workbench**. Under the **Hardware profile** section, you should see "NVIDIA GPU" as an option. Do not create a workbench -- just verify it appears, then cancel.

**Troubleshooting:**

- If `nvidia.com/gpu` does not appear in node capacity, check that the GPU Operator pods are running:

  ```bash
  oc get pods -n nvidia-gpu-operator
  ```

  All pods should be in `Running` or `Completed` state. Look for the `nvidia-driver-daemonset` and `nvidia-device-plugin-daemonset` pods specifically.

- If the HardwareProfile does not appear in the dashboard, verify the label is correct:

  ```bash
  oc get hardwareprofile nvidia-gpu -n redhat-ods-applications \
    -o jsonpath='{.metadata.labels.app\.opendatahub\.io/hardwareprofile}'
  ```

  It must return `true`.

- If the dashboard shows the profile but it is grayed out or unavailable when creating a workbench, check that `enabled: true` is set in the spec.

---

### Topic 5: Workload Resources with Kueue and Distributed Workloads (20-25 min)

**Instructor Notes:**

This is the most hands-on topic in the section. Students will enable Kueue, create all the queue resources, and verify everything works end to end. Take a moment to explain the Kueue architecture before diving into the exercise:

- **Kueue** is a Kubernetes-native job queuing system that manages quotas, priorities, and fair scheduling for batch and AI/ML workloads.
- **ResourceFlavor** defines a type of resource (e.g., "default CPU/memory" or "GPU nodes with specific labels/tolerations").
- **ClusterQueue** is cluster-scoped and defines the total resource budget across flavors.
- **LocalQueue** is namespace-scoped and connects a project to a ClusterQueue, allowing workloads in that namespace to be admitted.
- Kueue is especially important for distributed workloads (Ray clusters, PyTorch distributed training) where multiple pods compete for GPU resources.

Walk through the diagram: Workload --> LocalQueue --> ClusterQueue --> ResourceFlavor --> actual cluster nodes.

**Student Exercise: Enable and Configure Kueue**

This is a full hands-on exercise. Follow each step carefully.

> **Working directory:** All `cat` and `oc apply -f` commands below use relative paths from the root of the `workshop-setup` repository. Make sure you are in that directory:
> ```bash
> cd ~/workshop-setup   # or wherever you cloned the repo
> ```

**Step 1a: Install the Kueue Operator.**

RHOAI 3.2 only supports `Unmanaged` and `Removed` states for the Kueue component -- it does not manage Kueue directly. You must install the Kueue operator separately from OperatorHub first.

```bash
cat <<'EOF' | oc apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: openshift-kueue-operator
---
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: kueue-operator
  namespace: openshift-kueue-operator
spec:
  targetNamespaces: []
---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: kueue-operator
  namespace: openshift-kueue-operator
spec:
  channel: stable-v1.3
  installPlanApproval: Automatic
  name: kueue-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
EOF
```

Wait for the operator CSV to succeed:

```bash
oc get csv -n openshift-kueue-operator -w
```

Press Ctrl+C once it shows `Succeeded`.

**Step 1b: Enable Kueue in the DataScienceCluster.**

```bash
oc patch datasciencecluster default-dsc \
  --type merge \
  -p '{"spec":{"components":{"kueue":{"managementState":"Unmanaged"}}}}'
```

Expected output:

```
datasciencecluster.datasciencecluster.opendatahub.io/default-dsc patched
```

**Step 1c: Wait for the Kueue component to be ready.**

```bash
oc get kueue default-kueue -w
```

Press Ctrl+C once it shows a Ready status.

**Step 1d: Verify Kueue pods are running.**

```bash
oc get pods -n openshift-kueue-operator
```

Wait until you see pods in `Running` state. This may take 1-2 minutes.

> **Instructor note:** Setting kueue to `Unmanaged` means the RHOAI operator will create supporting resources (default ResourceFlavor, ClusterQueue, LocalQueue) but delegates the actual Kueue workload management to the standalone operator. This is different from components like `dashboard` which support `Managed` state.

> **Note:** When Kueue is enabled, the RHOAI operator automatically creates default resources: a `default-flavor` ResourceFlavor, an `nvidia-gpu-flavor` ResourceFlavor, a `default` ClusterQueue, and a `default` LocalQueue. In the following steps, we create additional custom resources to understand how the pieces fit together. You may see these auto-created resources alongside the ones you create.

**Step 2: Create the ResourceFlavors.**

Review the resource flavor definitions. We are creating two flavors: one for general CPU/memory workloads and one for GPU workloads that targets nodes with NVIDIA GPUs.

```bash
cat exercises/kueue-resource-flavor.yaml
```

The file contains:

```yaml
apiVersion: kueue.x-k8s.io/v1beta2
kind: ResourceFlavor
metadata:
  name: default-flavor
spec: {}
---
apiVersion: kueue.x-k8s.io/v1beta2
kind: ResourceFlavor
metadata:
  name: gpu-flavor
spec:
  nodeLabels:
    nvidia.com/gpu.present: "true"
  tolerations:
    - key: nvidia.com/gpu
      operator: Exists
      effect: NoSchedule
```

The `default-flavor` is a simple flavor with no constraints -- it matches any node. The `gpu-flavor` targets nodes labeled `nvidia.com/gpu.present=true` and includes a toleration for GPU node taints.

Apply the flavors:

```bash
oc apply -f exercises/kueue-resource-flavor.yaml
```

Expected output:

```
resourceflavor.kueue.x-k8s.io/default-flavor created
resourceflavor.kueue.x-k8s.io/gpu-flavor created
```

Verify:

```bash
oc get resourceflavors
```

**Step 3: Create the ClusterQueue.**

Review the ClusterQueue definition:

```bash
cat exercises/kueue-cluster-queue.yaml
```

The file contains:

```yaml
apiVersion: kueue.x-k8s.io/v1beta2
kind: ClusterQueue
metadata:
  name: cluster-queue
spec:
  namespaceSelector: {}
  resourceGroups:
    - coveredResources: ["cpu", "memory"]
      flavors:
        - name: default-flavor
          resources:
            - name: "cpu"
              nominalQuota: 8
            - name: "memory"
              nominalQuota: 32Gi
    - coveredResources: ["nvidia.com/gpu"]
      flavors:
        - name: gpu-flavor
          resources:
            - name: "nvidia.com/gpu"
              nominalQuota: 1
```

Key things to note:
- `namespaceSelector: {}` means any namespace with a LocalQueue pointing here can use this ClusterQueue
- The CPU/memory resource group uses the `default-flavor` with a quota of 8 CPUs and 32Gi memory
- The GPU resource group uses the `gpu-flavor` with a quota of 1 GPU (matching our single GPU node)

Apply:

```bash
oc apply -f exercises/kueue-cluster-queue.yaml
```

Expected output:

```
clusterqueue.kueue.x-k8s.io/cluster-queue created
```

Verify the ClusterQueue is active:

```bash
oc get clusterqueue cluster-queue
```

The output should show the queue with `PENDING WORKLOADS` at 0 initially.

**Step 4: Create the LocalQueue in the my-project namespace.**

Review the LocalQueue definition:

```bash
cat exercises/kueue-local-queue.yaml
```

The file contains:

```yaml
apiVersion: kueue.x-k8s.io/v1beta2
kind: LocalQueue
metadata:
  name: local-queue
  namespace: my-project
  annotations:
    kueue.x-k8s.io/default-queue: "true"
spec:
  clusterQueue: cluster-queue
```

The `kueue.x-k8s.io/default-queue: "true"` annotation makes this the default queue for the `my-project` namespace, so workloads submitted without specifying a queue will automatically use it.

Apply:

```bash
oc apply -f exercises/kueue-local-queue.yaml
```

Expected output:

```
localqueue.kueue.x-k8s.io/local-queue created
```

**Step 5: Label the namespace for Kueue enforcement.**

This label tells Kueue to manage workloads in this namespace:

```bash
oc label namespace my-project kueue.openshift.io/managed=true
```

Verify:

```bash
oc get namespace my-project --show-labels | grep kueue
```

**Step 6: Enable Kueue visibility in the OpenShift AI dashboard.**

By default, the Kueue/distributed workloads UI may be hidden. Enable it:

```bash
oc patch odhdashboardconfig odh-dashboard-config \
  -n redhat-ods-applications \
  --type merge \
  -p '{"spec":{"dashboardConfig":{"disableDistributedWorkloads":false}}}'
```

**Step 7: Verify the full Kueue setup.**

Check all resources are in place:

```bash
echo "=== ResourceFlavors ==="
oc get resourceflavors

echo ""
echo "=== ClusterQueue ==="
oc get clusterqueue cluster-queue

echo ""
echo "=== LocalQueue ==="
oc get localqueue -n my-project

echo ""
echo "=== Namespace Label ==="
oc get namespace my-project -o jsonpath='{.metadata.labels.kueue\.openshift\.io/managed}'
echo ""
```

All resources should exist and the namespace label should return `true`.

Now verify from the dashboard: navigate to **Distributed workload metrics** in the OpenShift AI dashboard. You should see the `cluster-queue` listed and the `my-project` project associated with it.

**Troubleshooting:**

- **Kueue pods not starting:** Check the DataScienceCluster status:

  ```bash
  oc get datasciencecluster default-dsc \
    -o jsonpath='{.status.conditions}' | python3 -m json.tool
  ```

- **ClusterQueue shows as inactive:** Ensure the ResourceFlavors referenced in the ClusterQueue actually exist. The names must match exactly.

- **LocalQueue not admitting workloads:** Verify the namespace label is applied and the `clusterQueue` field in the LocalQueue spec matches the ClusterQueue name exactly (`cluster-queue`).

- **Webhook errors when submitting workloads:** The Kueue webhook may take a minute to become ready after enabling the component. Wait and retry.

- **Dashboard does not show distributed workloads section:** Confirm the patch was applied:

  ```bash
  oc get odhdashboardconfig odh-dashboard-config \
    -n redhat-ods-applications \
    -o jsonpath='{.spec.dashboardConfig.disableDistributedWorkloads}'
  ```

  Should return `false`.

---

### Topic 6: Configuring External OIDC Identity Providers and Data Backup (10-15 min)

**Instructor Notes:**

This topic is **demo and overview only** -- students do not perform these steps on their clusters. The goal is awareness: students should understand what these capabilities are, when they would use them, and roughly how they are configured. Keep the pace conversational and use the code examples as visual aids on screen.

**OIDC Identity Providers (Technology Preview)**

Explain to students:

- OpenShift AI supports external OIDC identity providers as a Technology Preview feature in RHOAI 3.2.
- This is separate from OpenShift's built-in OAuth -- it allows OpenShift AI components (model serving endpoints, workbenches) to authenticate directly against an external IdP like Keycloak, Azure AD, or Okta.
- The configuration is done through a `GatewayConfig` patch on the Service Mesh or Authorino integration.

Show the following example on screen but **do not apply it**:

```yaml
# EXAMPLE ONLY - do not apply in this workshop
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayConfig
metadata:
  name: odh-gateway
  namespace: opendatahub-gateway
spec:
  oidc:
    issuerURL: "https://keycloak.example.com/realms/my-realm"
    clientID: "openshift-ai"
    clientSecretRef:
      name: oidc-client-secret
      namespace: opendatahub-gateway
```

Key points to highlight:

- The `issuerURL` points to the OIDC provider's discovery endpoint
- A Kubernetes Secret holds the client secret
- After configuration, you map IdP groups to OpenShift ClusterRoles (e.g., `odh-users`, `odh-admins`)
- This is Technology Preview -- not for production use yet, but important to understand for planning

**Data Backups with OADP**

Explain:

- OADP (OpenShift API for Data Protection) is the recommended approach for backing up OpenShift AI data.
- Critical data to back up: PVCs (workbench data, pipeline artifacts), ConfigMaps, Secrets, and project-scoped CRs.
- Backup scenarios: before removing a user, before upgrading RHOAI, before cluster migration, and as routine disaster recovery.

Show the high-level workflow on screen:

1. Install the OADP Operator from OperatorHub
2. Configure a `DataProtectionApplication` CR with an S3-compatible backup target
3. Create `Backup` CRs to snapshot specific namespaces or resources
4. Use `Restore` CRs to recover from backups

Emphasize that this is an operational best practice that students should implement in their production clusters, even though we do not have time to set it up in the workshop.

**Monitoring and Observability (Brief Overview)**

Cover these points verbally:

- RHOAI integrates with OpenShift's built-in monitoring stack (Prometheus, Alertmanager).
- Observability settings are controlled through the `DataScienceClusterInitialization` (DSCI) CR.
- You can enable metrics collection for model serving, pipeline runs, and workbench usage.
- The DSCI CR supports configuring log levels for the operator:

  ```bash
  # Example: check current DSCI observability settings (do not modify)
  oc get dsci default-dsci \
    -o jsonpath='{.spec.monitoring}' | python3 -m json.tool
  ```

- For audit logging, OpenShift's built-in node logs capture API server audit events:

  ```bash
  # Example: view audit logs on a node (do not run -- just show the command)
  oc adm node-logs <node-name> --path=kube-apiserver/audit.log | tail -20
  ```

**Wrap up this topic** by reminding students that OIDC, OADP, and monitoring are topics they will likely implement post-workshop as they move toward production. The key takeaway is knowing these capabilities exist and where to find the documentation.

---

**Section 2 Summary**

At this point, students have completed the following hands-on work:

- Created user groups (`rhods-admins`, `rhods-users`) and configured dashboard access
- Imported a custom notebook image (InstructLab code-server with CUDA)
- Explored and modified the `OdhDashboardConfig` to control dashboard behavior
- Verified GPU detection, node capacity, and the NVIDIA GPU HardwareProfile
- Enabled Kueue and created the full queue hierarchy (ResourceFlavor, ClusterQueue, LocalQueue)
- Labeled the `my-project` namespace for Kueue enforcement

They also have an overview understanding of OIDC integration, OADP backups, and monitoring configuration for production readiness.

**Suggested break:** 10-15 minutes before proceeding to Section 3.
---
## Creating a Workbench – Custom Images and Programmatic Provisioning in Red Hat OpenShift AI 3 {#creating-a-workbench-–-custom-images-and-programmatic-provisioning-in-red-hat-openshift-ai-3}

**Description:** As a cluster administrator, learn to provision secure, tailored workbenches and custom notebook images using OpenShift AI Custom Resource Definitions (CRDs) and the OpenShift CLI.

In this hands-on session, you'll:

* Build and register custom notebook images via the ImageStream CRD — enabling precise control over libraries, versions, dependencies (e.g., PyTorch, TensorFlow), and hardware optimizations (GPU/ROCm support) so they appear in the dashboard for data scientists.  
* Create reproducible workbenches programmatically with the Notebook CRD — configuring resources, environment variables, persistent storage, OAuth proxy for secure access, and integrations in project namespaces.

**Audience**: Cluster administrators and DevOps engineers supporting data science/ML teams.  
GitHub Repository:   
**Prerequisites** (cover upfront):

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* oc CLI installed and authenticated as cluster admin.  
* Basic YAML and OpenShift project/namespace knowledge.  
* A test namespace (e.g., oc new-project my-project).  
* Optional: Pre-pushed container image for custom image exercises.

**Duration**: 60–90 minutes, including hands-on labs.  
**Format**: Slides/overview → Live demo → Guided hands-on exercises → Q\&A/troubleshooting.  
**Key Outcomes**: Participants should leave able to:

* Build/register custom images visible in the dashboard.  
* Deploy secure, configurable workbenches via CRDs.  
* Know when to choose CRDs over the dashboard (automation, repeatability, admin control).

### Topic 1: Creating a Custom Image by Using the ImageStream CRD {#topic-1:-creating-a-custom-image-by-using-the-imagestream-crd}

**Goal**: Teach how admins create and register custom notebook images so data scientists can select them in the dashboard or Notebook CR.

**Core Concepts to Cover**:

* Default images are provided (e.g., with specific Python versions, libraries like PyTorch/TensorFlow).  
* Custom images are needed for specific library versions, additional tools, or hardware optimizations (e.g., GPU/ROCm support).  
* **ImageStream** acts as a pointer/reference to the actual container image in a registry.  
* Required namespace: redhat-ods-applications.  
* Specific labels/annotations make the image visible in the OpenShift AI dashboard.

### Topic 2: Creating a Workbench by Using the Notebook CRD {#topic-2:-creating-a-workbench-by-using-the-notebook-crd}

**Goal**: Provision a full workbench (Jupyter-based) programmatically, with custom image, resources, OAuth security, and connections.

**Core Concepts**:

* **Notebook** CR (from Kubeflow) defines the workbench pod/deployment.  
* Auto-injects OAuth proxy for secure access (inject-oauth: 'true').  
* Ties to a project namespace.  
* Configures env vars, resources (CPU/memory), probes, volumes.

---

## Configuring Your Model-Serving Platform – Deploying and Serving Models in Red Hat OpenShift AI 3 {#configuring-your-model-serving-platform-–-deploying-and-serving-models-in-red-hat-openshift-ai-3}

**Description:**

Learn to configure a robust model-serving platform in Red Hat OpenShift AI Self-Managed 3.2 for production-grade inference. This hands-on session covers enabling the KServe-based model serving platform, creating/managing ServingRuntimes and InferenceServices, deploying models from storage (S3/PVC/OCI), and optimizing for accelerators like NVIDIA GPUs.

You'll learn to:

* Enable and customize the model serving platform and runtimes.  
* Deploy models via dashboard or YAML (ServingRuntime \+ InferenceService CRDs).  
* Configure resources, endpoints, and accelerator support (e.g., vLLM for GPUs).  
* (Optional for interested participants) Enable and deploy with NVIDIA NIM for high-performance, GPU-optimized inference.

Includes live demos (dashboard \+ CLI), guided YAML/notebook exercises, deployment verification (API testing), and troubleshooting. Ideal for admins deploying scalable inference and data scientists integrating serving into ML workflows.

**Audience:** Cluster administrators, DevOps engineers, data scientists, and ML engineers deploying/serving models; some prior workbench and project experience recommended.

Prerequisites (cover upfront):

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* oc CLI installed and authenticated as cluster admin (for enabling platform/runtimes).  
* A data science project namespace with a workbench (from prior sessions).  
* Model storage access (e.g., S3 connection secret or PVC with a sample model like Granite or Llama).  
* Basic YAML, Python/Jupyter, and OpenShift knowledge.  
* Optional for NIM: GPU-enabled nodes (NVIDIA GPU Operator \+ NFD installed), NGC API key.

**Duration:** 90–120 minutes, including hands-on labs (core topics 60–90 min; NIM optional extension 20–30 min).

**Format:** Slides/overview → Live demos (dashboard \+ CLI) → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Enable/configure the model serving platform and preinstalled runtimes.  
* Create/deploy models using ServingRuntime and InferenceService CRDs.  
* Optimize for accelerators and test inference endpoints.  
* (Optional) Set up NVIDIA NIM for GPU-accelerated serving if hardware/API key available.

### Topic 1: Overview of Model Serving in OpenShift AI {#topic-1:-overview-of-model-serving-in-openshift-ai}

**Goal:** Understand the platforms, runtimes, and CRDs for serving models at scale.

**Core Concepts to Cover:**

* Model serving: Deploy trained models (from S3/PVC/OCI) for API-based inference (REST/gRPC).  
* Two platforms: KServe-based Model Serving Platform (recommended for production, single-model dedicated runtimes) vs. optional NVIDIA NIM Platform (GPU-optimized microservices).  
* Key CRDs: ServingRuntime (defines runtime env/image/ports/formats) and InferenceService (deploys model, links runtime, specifies storage/resources/endpoints).  
* Benefits: Auto-scaling, traffic routing, monitoring; supports large models (LLMs) with accelerators.  
* Prerequisites: KServe \+ OpenShift AI components installed/enabled.

### Topic 2: Enabling and Managing the Model Serving Platform {#topic-2:-enabling-and-managing-the-model-serving-platform}

**Goal:** Admin setup to make serving available in projects and enable runtimes.

**Core Concepts to Cover:**

* Enable via dashboard: Settings → Cluster settings → General settings → Model serving platforms → Check "Model serving platform".  
* Enable preinstalled runtimes: Settings → Model resources and operations → Serving runtimes → Toggle (e.g., vLLM for GPUs).  
* Add custom/tested runtimes: Dashboard → Add serving runtime → Upload/edit YAML (e.g., for Triton, MLServer).  
* Deployment options: Set default strategy (RollingUpdate recommended).  
* Hands-on: Enable platform/runtimes, verify with oc get servingruntimes \-n \<project\>.

### Topic 3: Deploying Models with ServingRuntimes and InferenceServices {#topic-3:-deploying-models-with-servingruntimes-and-inferenceservices}

**Goal:** Hands-on model deployment via dashboard and CLI/YAML for production control.

**Core Concepts to Cover:**

* Dashboard flow: Data science projects → Models tab → Deploy model → Select runtime/format/storage → Configure resources/endpoints.  
* YAML approach: Create ServingRuntime (e.g., vLLM with image/args/ports), then InferenceService (link runtime, model path, GPU requests).  
* Storage: Use connection secrets (AWS/S3) or PVCs; path to model dir.  
* Resources: Limits/requests for CPU/memory/GPU; tolerations/affinity for hardware.  
* Verification: Check pod status (oc get pods), test endpoint (curl with token).  
* Hands-on exercise: Deploy a sample model (e.g., Granite-7B via vLLM), query inference API.

### Topic 4: Accelerator Support and Optimization {#topic-4:-accelerator-support-and-optimization}

**Goal:** Configure serving for hardware accelerators (focus on NVIDIA GPUs as primary).

**Core Concepts to Cover:**

* Enable accelerators: Install NFD \+ GPU Operator; verify node labels (nvidia.com/gpu).  
* Runtimes: Use preinstalled vLLM NVIDIA GPU ServingRuntime; supports distributed (tensor-parallel-size).  
* Other accelerators: Brief on Intel Gaudi/AMD GPU/IBM Spyre (TP on x86).  
* Custom args: e.g., \--tensor-parallel-size=4 for multi-GPU, skip warm-up env var.  
* Monitoring: Add Prometheus annotations to ServingRuntime/InferenceService.  
* Hands-on: Deploy GPU model if hardware available; test performance.

### Topic 5 (Optional – for Interested Participants): NVIDIA NIM Model Serving {#topic-5-(optional-–-for-interested-participants):-nvidia-nim-model-serving}

**Goal:** Explore optional NVIDIA-optimized inference if GPUs and NGC access are available.

**Core Concepts to Cover:**

* NIM overview: NVIDIA Inference Microservices for secure, high-performance GPU inference (part of AI Enterprise).  
* Enable: Dashboard → Applications → Explore → NVIDIA NIM tile → Enable → Enter NGC personal API key (prereq: NVIDIA account \+ Viewer role).  
* Deploy: Select NIM model during deployment → Configure replicas/server size/hardware profile.  
* Benefits: Optimized containers for generative AI; requires model serving platform first.  
* Hands-on (if time/hardware): Enable NIM, deploy a NIM model, test inference.  
* Note: Skip if no GPU/API key; presented as advanced/optional extension.

## Managing Model Registries in Red Hat OpenShift AI Self-Managed 3 {#managing-model-registries-in-red-hat-openshift-ai-self-managed-3}

**Description:**

Establish centralized governance for AI models with model registries in Red Hat OpenShift AI Self-Managed 3.2. This hands-on session teaches cluster admins how to enable the model registry component, create and configure MySQL-backed registries via the dashboard, secure access with RBAC groups, edit details (e.g., connections), and manage lifecycle (including deletion).

You'll learn to:

* Enable the modelregistry component and create instances (dashboard \+ YAML).  
* Connect registries to external MySQL databases (with TLS/CA options).  
* Grant permissions to users/groups for registration, versioning, sharing, and promotion.  
* Edit/delete registries and verify setup for team workflows.

Includes live dashboard demos, guided UI/YAML exercises, RBAC verification, troubleshooting, and best practices for MLOps traceability. Pairs with model catalog discovery and serving for end-to-end model lifecycle management.

**Audience:** Cluster administrators and DevOps engineers enabling model governance; data scientists benefit from understanding access flows.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard as cluster admin.  
* oc CLI installed and authenticated as cluster admin (for component enabling/verification).  
* An external MySQL database (v8.x recommended; v5.x minimum) accessible from the cluster (host/port/credentials ready; optional TLS CA).  
* A test project/namespace with users/groups for RBAC testing.  
* Basic YAML and dashboard navigation knowledge.

**Duration:** 75–100 minutes, including hands-on labs (focused scope allows shorter session).

**Format:** Slides/overview → Live dashboard demos → Guided hands-on UI/YAML exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Enable and create model registries via dashboard and CRD.  
* Configure secure MySQL connections (including TLS).  
* Manage RBAC permissions for collaborative model registration/versioning.  
* Edit, verify, and delete registries while maintaining governance.

### Topic 1: Overview of Model Registries and the Model Catalog {#topic-1:-overview-of-model-registries-and-the-model-catalog}

**Goal:** Understand the role of model registries in MLOps and differentiate from the model catalog.

**Core Concepts to Cover:**

* Model registry: Central repo for registering/versioning/managing AI model lifecycle; stores metadata (project/env, hyperparameters, metrics, events); enables sharing, deployment tracking, governance.  
* Complements model catalog: Curated gen AI models (Red Hat, IBM, Meta, Nvidia, Mistral, Google) for discovery/evaluation; registry for custom/team models post-selection.  
* Benefits: Traceability, collaboration, promotion from experimentation to serving.  
* Backend: External MySQL (no internal store); admin-created instances in rhoai-model-registries namespace.  
* Hands-on intro: Navigate dashboard → Settings → Model resources and operations → AI registry settings; review existing (if any).

### Topic 2: Enabling the Model Registry Component {#topic-2:-enabling-the-model-registry-component}

**Goal:** Activate the component if not already enabled (default in fresh 3.2 installs).

**Core Concepts to Cover:**

* Enabled via Red Hat OpenShift AI Operator (v2.14+).  
* Dashboard check: If missing, enable in Data Science Cluster CR.  
* YAML method: Edit default-dsc instance → Add spec.components.modelregistry: managementState: Managed, registriesNamespace: rhoai-model-registries.  
* Verification: oc get namespace rhoai-model-registries; check model-registry-operator pods in redhat-ods-applications.  
* Hands-on: Apply YAML patch if needed; confirm namespace/pods Running.

### Topic 3: Creating and Configuring a Model Registry {#topic-3:-creating-and-configuring-a-model-registry}

**Goal:** Hands-on creation and secure connection setup.

**Core Concepts to Cover:**

* Dashboard flow: Settings → AI registry settings → Create model registry → Name/description/resource name (lowercase alphanum/hyphen, unique, non-editable later).  
* Database connection: Host (e.g., \<hostname\>.\<namespace\>.svc.cluster.local), port, username/password/database.  
* TLS (if enforced): Add CA cert (cluster-wide bundle, Red Hat bundle, existing ConfigMap/secret, or upload PEM → creates ConfigMap db-credential with ca.crt).  
* Post-creation: Registry appears in list; auto-creates RBAC (e.g., registry-users-\<name\>).  
* Hands-on exercise: Create a registry, connect to test MySQL (simulate credentials if no real DB), verify in list and rhoai-model-registries namespace.

### Topic 4: Managing Permissions and Access {#topic-4:-managing-permissions-and-access}

**Goal:** Secure collaborative access with RBAC.

**Core Concepts to Cover:**

* Permissions: Admin creates registry → grants via groups (e.g., add system:authenticated for broad access or custom groups).  
* RBAC auto-generated: Roles like registry-users-\<name\>, groups \<name\>-users in rhoai-model-registries.  
* User actions (with access): Register models, version, edit metadata, deploy/track, archive/restore/delete.  
* Dashboard view: Model registry tab for registered models.  
* Hands-on: Add a test group/user to registry access; verify non-admin user can see/register (use separate browser/incognito).

### Topic 5: Editing, Deleting, and Best Practices {#topic-5:-editing,-deleting,-and-best-practices}

**Goal:** Handle lifecycle and operational tips.

**Core Concepts to Cover:**

* Edit: Dashboard action menu → Edit details (name/description/connection/TLS); save → restarts if needed.  
* Delete: Action menu → Delete; database persists (admin cleans separately).  
* Best practices: Use MySQL 8.x; unique resource names; add TLS for security; integrate with serving/pipelines for promotion.  
* Troubleshooting: Pod not Running, connection failures (check creds/TLS), RBAC issues.  
* Hands-on (optional): Edit a registry (update description), delete test one, discuss cleanup.

---

# Data scientists, ML engineers, and MLOps practitioners {#data-scientists,-ml-engineers,-and-mlops-practitioners}

## Working in Your Data Science IDE – Maximizing Productivity with JupyterLab, code-server, and More in Red Hat OpenShift AI 3 {#working-in-your-data-science-ide-–-maximizing-productivity-with-jupyterlab,-code-server,-and-more-in-red-hat-openshift-ai-3}

**Description:**

Level up your development experience inside Red Hat OpenShift AI Self-Managed 3.2 workbenches. This hands-on session guides data scientists and ML engineers through effectively using the built-in data science IDEs — JupyterLab for interactive notebooks, code-server (VS Code in the browser) for extensible editing, and RStudio Server (Technology Preview) for R workflows. You'll create/import notebooks, collaborate via Git (clone/pull/push), manage Python environments with requirements.txt, install extensions in code-server, leverage terminals for commands, and troubleshoot common issues.

You'll learn to:

* Access and navigate JupyterLab and code-server from running workbenches.  
* Create/upload/import notebooks/files and integrate Git for version control/collaboration.  
* Install/manage Python packages consistently across sessions.  
* Customize code-server with extensions and use terminals for advanced tasks.

Includes live IDE demos, guided exercises (notebook creation, Git repo clone/push, package installs, extension addition), verification (committed changes, installed packages), troubleshooting (e.g., 403 errors, resource limits), and best practices for reproducible ML development. Ties together workbench/project setup for efficient, collaborative workflows.

**Audience:** Data scientists, ML engineers, and AI developers working daily in OpenShift AI workbenches; prior experience with projects/workbenches recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard with a project containing at least one workbench (from Session 13).  
* Workbenches based on relevant images: JupyterLab-enabled (e.g., Standard Data Science), code-server image (for VS Code exercises), optional RStudio TP image.  
* A Git repository (public or private with read/write access) for collaboration demos (e.g., GitHub repo with sample notebooks).  
* Optional: requirements.txt file or sample packages to install; S3 connection for data files.  
* Basic Python, Git, and web IDE familiarity.

**Duration:** 90–120 minutes, including hands-on labs (core JupyterLab/code-server 70–90 min; Git/packages/extensions extension).

**Format:** Slides/overview → Live IDE \+ dashboard demos → Guided hands-on exercises in running workbenches → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Open and navigate JupyterLab/code-server IDEs from workbenches.  
* Create/import notebooks/files and collaborate effectively with Git (clone/pull/push).  
* Install/manage Python packages reproducibly using requirements.txt.  
* Customize code-server with extensions and use terminals for Git/pip commands.

### Topic 1: Overview of Data Science IDEs in OpenShift AI {#topic-1:-overview-of-data-science-ides-in-openshift-ai}

**Goal:** Understand supported IDEs, workbench images, and access flows.

**Core Concepts to Cover:**

* Supported IDEs: JupyterLab (interactive notebooks, 40+ languages incl. Python/R, built-in Git/terminal), code-server (VS Code-like with extensions for editing/debugging/themes), RStudio Server (TP for R-focused work; unavailable in disconnected envs).  
* Workbench images: Pre-built with IDE \+ packages (e.g., JupyterLab images include kernels; code-server for extensible VS Code).  
* Access: Dashboard → Projects → Workbenches → Start workbench → Open icon/link → launches IDE in browser.  
* Benefits: Web-based, persistent (with PVC), collaborative (Git), integrated with connections/storage.  
* Hands-on intro: Start a JupyterLab and code-server workbench → open each IDE → explore layout (File Browser/Explorer, terminals, Git pane/Source Control).

### Topic 2: Working Effectively in JupyterLab {#topic-2:-working-effectively-in-jupyterlab}

**Goal:** Create/import notebooks, collaborate with Git, and manage packages.

**Core Concepts to Cover:**

* Notebooks: File → New → Notebook (select kernel); Upload files via File Browser.  
* Import from Git: Git pane → Clone repository (paste HTTPS URL, auth if private); or terminal: git clone \<url\>.  
* Git collaboration: Pull changes (Git pane → Pull); stage/commit/push (stage files, commit message, push to remote).  
* Package management: \!pip list to view; create requirements.txt (exact versions e.g., altair==5.4.0), run \!pip install \-r requirements.txt.  
* Terminal: File → New → Terminal for git/pip commands.  
* Hands-on exercise: Create new notebook, upload sample file, clone Git repo, make change/commit/push, install package from requirements.txt.

### Topic 3: Working Effectively in code-server (VS Code Web) {#topic-3:-working-effectively-in-code-server-(vs-code-web)}

**Goal:** Leverage code-server's extensibility for advanced editing and customization.

**Core Concepts to Cover:**

* Workbench setup reminder: During creation, select code-server image, add env vars (e.g., for S3), attach storage/connections.  
* Notebooks/files: Explorer → Open File (local), Upload via drag-drop or menu.  
* Git: Source Control pane → Clone (Command Palette: Git: Clone), Pull/Push (stage, commit & sync).  
* Package management: Terminal → pip list, create/save requirements.txt, pip install \-r requirements.txt.  
* Extensions: Extensions icon → Search Open VSX Registry → Install (e.g., Python, Jupyter, GitLens, themes).  
* No Elyra pipelines support in code-server.  
* Hands-on: Open code-server workbench → clone Git repo, install 2–3 extensions (Python \+ Jupyter), create/edit notebook, install packages via terminal.

### Topic 4: Best Practices, Customization, and Troubleshooting {#topic-4:-best-practices,-customization,-and-troubleshooting}

**Goal:** Ensure reproducibility, security, and smooth operation.

**Core Concepts to Cover:**

* Reproducibility: Use requirements.txt with pinned versions; commit notebooks with outputs cleared if needed.  
* Customization: Env vars during workbench creation (e.g., AWS keys); custom images for pre-installed packages.  
* Troubleshooting: 403 Forbidden (check group membership via admin), workbench won't start (check events/resources), disk full (contact admin for PVC increase), Git auth fails (verify credentials/token).  
* Best practices: Use terminals for complex commands, pull often for collaboration, test installs in fresh sessions.  
* Hands-on (optional): Intentionally cause a common issue (e.g., wrong Git URL), troubleshoot via dashboard/events; install extension and verify functionality.

## Working with AI Pipelines – Building, Scheduling, and Tracking ML Workflows in Red Hat OpenShift AI 3 {#working-with-ai-pipelines-–-building,-scheduling,-and-tracking-ml-workflows-in-red-hat-openshift-ai-3}

**Description:**

Automate and scale reproducible ML workflows with AI pipelines in Red Hat OpenShift AI Self-Managed 3.2. This hands-on session teaches data scientists and ML engineers how to configure pipeline servers, import/compile pipelines (YAML/KFP SDK), create/run/schedule executions (ad-hoc, periodic/Cron), monitor runs (logs, artifacts, metrics), use experiments for comparison, leverage Elyra in JupyterLab for notebook-to-pipeline, control caching, and troubleshoot common issues.

You'll learn to:

* Set up pipeline servers with S3 storage and run pipelines from dashboard or Elyra.  
* Import/version pipelines, create experiments, and execute/schedule runs with parameters.  
* View logs/artifacts (S3-backed), compare runs, and manage caching for efficiency.  
* Build visual pipelines in JupyterLab Elyra and export/run them remotely.

Includes live demos (dashboard \+ JupyterLab), guided exercises (import pipeline → schedule run → view logs/artifacts → Elyra creation), verification (run status, S3 artifacts, comparisons), troubleshooting (caching, S3 creds, DSPA errors), and best practices for production MLOps. Integrates with workbenches, S3, and distributed jobs for full lifecycle automation.

**Audience:** Data scientists, ML engineers, and MLOps practitioners automating workflows; prior workbench/S3/project experience recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard with a project.  
* Pipeline server configured in the project (dashboard: Pipelines → Configure pipeline server; S3 bucket with write access for artifacts).  
* A workbench (JupyterLab-based image with Elyra, e.g., Standard Data Science/PyTorch).  
* Sample pipeline YAML (from KFP SDK or examples) or notebook for Elyra.  
* Optional: KFP SDK installed in notebook (pip install kfp), Git repo with pipeline code.  
* Basic Python, YAML, and dashboard navigation.

**Duration:** 90–120 minutes, including hands-on labs (core import/run/monitor 60–80 min; Elyra/scheduling extension).

**Format:** Slides/overview → Live dashboard \+ JupyterLab demos → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Configure/import/version pipelines and manage experiments/runs.  
* Create/schedule pipeline executions with parameters and monitor logs/artifacts.  
* Build/run visual pipelines in Elyra JupyterLab with runtime configs.  
* Control caching, compare runs, and resolve common DSPA/S3 issues.

### Topic 1: Overview of AI Pipelines and Pipeline Server Setup {#topic-1:-overview-of-ai-pipelines-and-pipeline-server-setup}

**Goal:** Understand pipelines, components, and server configuration for artifact storage.

**Core Concepts to Cover:**

* Pipelines: Portable ML workflows (data prep → training → serving) using Docker/KFP 2.0 SDK; YAML-defined, Tekton-executed.  
* Key elements: Pipeline server (per-project, S3-backed artifacts), experiments (run grouping/comparison), runs (executions: active/scheduled/archived), versions (iterative changes), artifacts (S3 paths like /pipelines/\<id\>), caching (reuse unchanged steps).  
* Server config: S3 (access/secret/endpoint/region/bucket), optional external DB (MySQL/MariaDB), caching enabled.  
* Hands-on intro: Dashboard → Develop & train → Pipelines → Configure pipeline server (verify S3 details); check status.

### Topic 2: Importing, Versioning, and Managing Pipelines {#topic-2:-importing,-versioning,-and-managing-pipelines}

**Goal:** Bring pipelines into the system and handle iterations.

**Core Concepts to Cover:**

* Import: Develop & train → Pipelines → Import pipeline → Upload YAML/URL → Name/description.  
* Versioning: Import new version (select existing pipeline) → Incremental changes; view graph/spec/details.  
* Manage: Delete pipeline/version (no active runs), download YAML, view list/expand for versions.  
* Hands-on exercise: Upload sample YAML (e.g., from KFP examples or compile simple one); import version → verify graph/spec.

### Topic 3: Creating Experiments, Running, and Scheduling Pipelines {#topic-3:-creating-experiments,-running,-and-scheduling-pipelines}

**Goal:** Execute pipelines ad-hoc or scheduled with parameters.

**Core Concepts to Cover:**

* Experiments: Develop & train → Experiments → Create → Name/description (group runs).  
* Runs: From experiment → Create run → Select pipeline/version → Params → Submit; view active/schedules.  
* Scheduling: Schedules tab → Create scheduled run → Trigger (periodic/Cron), concurrency (1–10), catch-up, params.  
* Duplicate/stop/archive/restore: Action menus; compare up to 10 runs (params/metrics/ROC).  
* Hands-on: Create experiment → Run pipeline with params → Schedule periodic run → Duplicate/stop → Compare runs.

### Topic 4: Monitoring Runs, Logs, Artifacts, and Caching {#topic-4:-monitoring-runs,-logs,-artifacts,-and-caching}

**Goal:** Track execution and optimize with caching/artifacts.

**Core Concepts to Cover:**

* Monitoring: Runs/Executions/Artifacts tabs → View graph/status/logs/metrics.  
* Logs: Run details → Graph → Step → Logs (search/download; last 500 lines, refresh).  
* Artifacts: Pipelines → Artifacts → Preview/download from S3 URI.  
* Caching: Enabled default (green icon, no logs for cached); disable per-task (set\_caching\_options(False)), run (enable\_caching=False), or server-wide.  
* Hands-on exercise: Run pipeline → View logs/artifacts → Re-run (observe caching) → Disable caching → Re-run (force execution).

### Topic 5: Building Pipelines in JupyterLab with Elyra (Hands-On Focus) {#topic-5:-building-pipelines-in-jupyterlab-with-elyra-(hands-on-focus)}

**Goal:** Create visual pipelines directly from notebooks.

**Core Concepts to Cover:**

* Elyra: In JupyterLab launcher → Pipeline Editor → Add notebook/script nodes → Dependencies → Runtime config (API endpoint, S3 bucket/creds).  
* Runtime configs: Sidebar → Runtimes → Create/update (bearer token auth, S3 details).  
* Run/export: From editor → Run (creates experiment/run) or Export YAML.  
* Caching: Disable per-node/pipeline in properties.  
* Hands-on: Open workbench → Elyra editor → Build simple pipeline (e.g., data load → train) → Config runtime → Run → Verify in dashboard (logs/artifacts).

### Topic 6: Troubleshooting and Best Practices {#topic-6:-troubleshooting-and-best-practices}

**Goal:** Resolve issues and ensure reproducibility.

**Core Concepts to Cover:**

* Common: S3 creds/endpoint errors (reconfigure server), DSPA issues (ObjectStorageAvailable/DatabaseAvailable), cert trust (add CA), logs partial (refresh/view raw).  
* Best practices: Use fixed versions in schedules, pin params, S3 for artifacts, experiments for comparison, disable caching for debug.  
* Hands-on (optional): Simulate error (wrong S3 key) → Troubleshoot via dashboard/logs → Fix.

## Working on Projects – Organizing Collaborative AI/ML Workflows in Red Hat OpenShift AI 3 {#working-on-projects-–-organizing-collaborative-ai/ml-workflows-in-red-hat-openshift-ai-3}

**Description:**

Master project-based organization in Red Hat OpenShift AI Self-Managed 3.2 to collaborate effectively on data science and ML tasks. This hands-on session guides data scientists and ML engineers through creating/managing projects as isolated workspaces, configuring workbenches with optimal images/storage/connections, adding data sources, granting team access with RBAC roles, and creating project-scoped custom resources (e.g., images or runtimes via YAML).

You'll learn to:

* Create/update/delete projects and understand their role as containers for workbenches, connections, storage, models, and pipelines.  
* Build and manage workbenches (select IDEs/images, attach storage/connections, start/stop/update).  
* Configure connections and cluster storage for secure, persistent data access.  
* Share projects with team members (Admin/Contributor roles) and create project-scoped resources for customization.

Includes live dashboard demos, guided UI exercises (create project → workbench → connection/storage → share access), verification steps, troubleshooting (e.g., storage migration, access issues), and best practices for team-scale collaboration. Serves as a capstone integrating prior sessions into cohesive project workflows.

**Audience:** Data scientists, ML engineers, and AI practitioners collaborating in projects; cluster admins benefit from user-perspective insights.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard with user permissions (or admin for full demos).  
* Basic dashboard navigation; optional: sample data connection/S3 bucket, existing users/groups for RBAC testing.  
* A test project (create one during session if needed).  
* Familiarity with workbenches/connections from prior sessions.

**Duration:** 90–120 minutes, including hands-on labs (core project/workbench setup 60–80 min; access/storage advanced extension).

**Format:** Slides/overview → Live dashboard demos → Guided hands-on UI exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Create and manage projects as secure, collaborative workspaces.  
* Configure workbenches with appropriate images, storage, and connections for ML tasks.  
* Add/update connections and cluster storage for data persistence/access.  
* Grant/revoke project access with Admin/Contributor roles and understand project-scoped customization.

### Topic 1: Overview of Projects and Their Components {#topic-1:-overview-of-projects-and-their-components}

**Goal:** Understand projects as the foundation for organized AI workflows.

**Core Concepts to Cover:**

* Project: Isolated namespace containing workbenches (JupyterLab/code-server/RStudio TP), cluster storage (PVCs), connections (S3/URI/OCI), pipelines, models/servers, and access controls.  
* Benefits: Collaboration, resource isolation, security (RBAC), persistence (data stays on cluster).  
* Overlaps: Workbenches (Session 1), connections/S3 (Session 12), models/serving (Sessions 4/7–9), distributed workloads (Session 11).  
* Hands-on intro: Dashboard → Projects; explore list/details; note tabs (Workbenches, Connections, Storage, Access, etc.).

### Topic 2: Creating, Updating, and Deleting Projects {#topic-2:-creating,-updating,-and-deleting-projects}

**Goal:** Hands-on lifecycle management of projects.

**Core Concepts to Cover:**

* Create: Projects → Create project → Name/description/resource name (immutable Kubernetes namespace).  
* Update: Edit name/description (resource name fixed).  
* Delete: Permanent; removes all associated resources (workbenches, storage, connections, pipelines).  
* Best practices: Descriptive names, plan for cleanup, back up data before delete.  
* Hands-on exercise: Create a new test project, add description, verify details page opens; update name; simulate delete (or skip if destructive).

### Topic 3: Creating and Managing Workbenches in a Project {#topic-3:-creating-and-managing-workbenches-in-a-project}

**Goal:** Configure isolated development environments with IDEs, images, and resources.

**Core Concepts to Cover:**

* Workbench images: Defaults (CUDA/GPU, Standard Data Science, PyTorch/TensorFlow, Minimal Python, ROCm/AMD, code-server, RStudio TP); select version/packages.  
* Creation: Project → Workbenches tab → Create workbench → Name/image/deployment size (hardware profiles TP), env vars, cluster storage (new/existing PVC), connections (attach existing/new).  
* Start/stop/update/delete: Dashboard actions; update image/size/connections (may restart).  
* Hands-on: In test project → Create workbench (select PyTorch image, medium size, new PVC, attach S3 connection); start it → open Jupyter; update size/image; stop/delete.

### Topic 4: Managing Connections and Cluster Storage {#topic-4:-managing-connections-and-cluster-storage}

**Goal:** Enable secure data access and persistence within projects.

**Core Concepts to Cover:**

* Connections: Project → Connections tab → Add (S3/URI/OCI) → Fill details (keys/endpoint/bucket); update/delete.  
* Cluster storage: Add during workbench creation or separately → Storage class/access mode (RWO default, RWX risks for shared), size (increase only).  
* Migration: Stop workbench → new storage → rsync data → re-mount.  
* Hands-on exercise: Add/update S3 connection; create/attach storage to workbench; verify mount in Jupyter (e.g., ls /opt/app-root/src); discuss RWX best practices.

### Topic 5: Managing Access and Project-Scoped Resources {#topic-5:-managing-access-and-project-scoped-resources}

**Goal:** Enable collaboration and advanced customization.

**Core Concepts to Cover:**

* Access: Project → Access tab → Add users/groups → Assign Admin (full control) or Contributor (edit resources). Update/revoke access.  
* Project-scoped resources: YAML imports for custom images, KServe runtimes, hardware profiles (via OpenShift Console or oc apply in project namespace).  
* Hands-on: Add a test user/group as Contributor → verify they can create workbench; brief YAML demo (import sample custom runtime if time).

## Working with Data in an S3-Compatible Object Store – Accessing and Managing Data from Workbenches in Red Hat OpenShift AI 3 {#working-with-data-in-an-s3-compatible-object-store-–-accessing-and-managing-data-from-workbenches-in-red-hat-openshift-ai-3}

**Description:**

Integrate external object storage seamlessly into your AI workflows in Red Hat OpenShift AI Self-Managed 3.2. This hands-on session shows data scientists and ML engineers how to connect workbenches to S3-compatible stores (MinIO, Ceph, AWS S3, IBM COS), create secure Boto3 clients in Jupyter, and perform essential operations: listing/creating buckets, uploading/downloading/copying/deleting files, and troubleshooting endpoints or self-signed certs.

You'll learn to:

* Start a workbench and configure/use S3 connections for credentials.  
* Install Boto3 and create clients using environment variables from connections.  
* Run CRUD operations on buckets/objects via the official s3client\_examples.ipynb notebook.  
* Handle endpoint formatting and self-signed certificate trusts (admin overview).

Includes live notebook demos, guided exercises (clone repo → run cells with real/test storage), verification (list outputs, file transfers), troubleshooting (connection errors, cert issues), and best practices for secure/performant data access in pipelines/training. Complements data ingestion for distributed workloads, model serving, and registries.

**Audience:** Data scientists, ML engineers, and AI practitioners working with large/external datasets; some workbench/connection experience recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard.  
* A project with a workbench created (from Session 1; recommend image with Python support, e.g., Standard Data Science).  
* An S3-compatible object store accessible (e.g., MinIO on-cluster, AWS S3, Ceph) with:  
  * Bucket(s) containing sample files (CSV/images/models for demos).  
  * Access/secret keys and endpoint URL.  
* A configured connection in the project (from dashboard: Data connections → Create connection → S3 type; fills env vars like AWS\_ACCESS\_KEY\_ID).  
* Optional: Admin access for self-signed cert patching demo; test bucket with write permissions.  
* Basic Jupyter/Python and S3 concepts.

**Duration:** 75–100 minutes, including hands-on labs (notebook-focused keeps it practical).

**Format:** Slides/overview → Live Jupyter \+ dashboard demos → Guided hands-on notebook exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Connect workbenches to S3-compatible storage using dashboard connections.  
* Create and verify Boto3 clients in notebooks for secure access.  
* Perform bucket/object operations (list/create/upload/download/delete/copy).  
* Troubleshoot common issues like endpoint formatting or self-signed certs.

### Topic 1: Overview of S3-Compatible Storage in OpenShift AI {#topic-1:-overview-of-s3-compatible-storage-in-openshift-ai}

**Goal:** Understand integration benefits, supported stores, and workflow.

**Core Concepts to Cover:**

* Purpose: Access large/external datasets (training data, artifacts) from workbenches without local copies; enables scalable AI pipelines.  
* Supported: MinIO (on-cluster), Ceph, IBM Cloud Object Storage, AWS S3, other S3-compatible.  
* Key integration: Dashboard connections inject env vars (AWS\_ACCESS\_KEY\_ID, AWS\_SECRET\_ACCESS\_KEY, AWS\_S3\_ENDPOINT, AWS\_DEFAULT\_REGION) for Boto3.  
* Tools: Boto3 AWS SDK (primary); notebook examples from official repo.  
* Hands-on intro: Dashboard → Projects → select project → Data connections; verify/create S3 connection; start workbench → open Jupyter.

### Topic 2: Setting Up the Environment in a Workbench {#topic-2:-setting-up-the-environment-in-a-workbench}

**Goal:** Prepare Jupyter for S3 access using connections and Boto3.

**Core Concepts to Cover:**

* Start workbench → Open JupyterLab.  
* Clone examples: \!git clone https://github.com/opendatahub-io/odh-doc-examples.git.  
* Open s3client\_examples.ipynb.  
* Install/upgrade: \!pip3 install \--upgrade pip then \!pip3 install boto3; check \!pip3 show boto3.  
* Env vars from connection: Access via os.environ.get('AWS\_ACCESS\_KEY\_ID'), etc.  
* Hands-on exercise: Clone repo, install Boto3, print env vars to confirm connection injection.

### Topic 3: Creating and Verifying an S3 Client {#topic-3:-creating-and-verifying-an-s3-client}

**Goal:** Establish secure client connection for operations.

**Core Concepts to Cover:**

* Code:  
  Python

```
import os, boto3
key_id = os.environ.get('AWS_ACCESS_KEY_ID')
secret_key = os.environ.get('AWS_SECRET_ACCESS_KEY')
endpoint = os.environ.get('AWS_S3_ENDPOINT')
region = os.environ.get('AWS_DEFAULT_REGION')
session = boto3.Session(aws_access_key_id=key_id, aws_secret_access_key=secret_key)
s3_client = boto3.client('s3',
    aws_access_key_id=key_id,
    aws_secret_access_key=secret_key,
    config=boto3.session.Config(signature_version='s3v4'),
    endpoint_url=endpoint,
    region_name=region)
```

* Verify: s3\_client.list\_buckets() → expect HTTP 200 \+ bucket list.  
* Hands-on: Run client creation cells; troubleshoot if fails (check endpoint/credentials).

### Topic 4: Core Bucket and Object Operations {#topic-4:-core-bucket-and-object-operations}

**Goal:** Hands-on CRUD with buckets/files.

**Core Concepts to Cover:**

* List buckets: s3\_client.list\_buckets() → print names.  
* Create bucket: s3\_client.create\_bucket(Bucket='my-test-bucket').  
* List objects: s3\_client.list\_objects\_v2(Bucket='bucket', Prefix='path/') → print keys.  
* Upload: s3\_client.upload\_file('local.csv', 'bucket', 'remote/path.csv').  
* Download: s3\_client.download\_file('bucket', 'remote.csv', '/tmp/local.csv').  
* Copy: copy\_source \= {'Bucket': 'src', 'Key': 'file'}; s3\_client.copy(copy\_source, 'dest', 'new\_key').  
* Delete object: s3\_client.delete\_object(Bucket='bucket', Key='file').  
* Delete bucket: s3\_client.delete\_bucket(Bucket='empty-bucket') (must be empty).  
* Hands-on exercise: Create test bucket, upload sample file (e.g., CSV from workbench), list/download/copy/delete; verify each step.

### Topic 5: Endpoint Formatting, Self-Signed Certs, and Troubleshooting {#topic-5:-endpoint-formatting,-self-signed-certs,-and-troubleshooting}

**Goal:** Handle real-world connectivity issues (admin/user view).

**Core Concepts to Cover:**

* Endpoints: MinIO (http://minio-cluster.local:9000), AWS (https://bucket.s3.region.amazonaws.com), others per provider.  
* Self-signed certs (admin): Patch DSCInitialization with kube-root-ca.crt bundle via oc commands (export current CA, append, patch).  
* Common issues: Wrong endpoint → connection refused; bad creds → 403; empty bucket required for delete.  
* Best practices: Use HTTPS where possible; verify with list\_buckets(); avoid hardcoding creds (use env vars/connections).  
* Hands-on (optional): Intentionally wrong endpoint → observe error → fix; discuss admin cert patching if time.

## Experimenting with Models in the Gen AI Playground – Prototyping, RAG, and Tool Integration in Red Hat OpenShift AI 3 {#experimenting-with-models-in-the-gen-ai-playground-–-prototyping,-rag,-and-tool-integration-in-red-hat-openshift-ai-3}

**Description:**

Prototype and evaluate generative AI models interactively in the Gen AI Playground (Technology Preview) within Red Hat OpenShift AI Self-Managed 3.2. This hands-on session shows data scientists and AI engineers how to configure playground instances per project, chat with deployed models (foundation or custom), test prompt engineering with document-based RAG, authorize/use MCP servers for external tools, tune parameters (temperature, system instructions), and export setups as Python code templates for local iteration.

You'll learn to:

* Create/configure playgrounds tied to AI asset endpoints (deployed models).  
* Run multi-turn chats, upload documents for RAG context, and force tool usage.  
* Adjust inference parameters and toggle streaming for real-time testing.  
* Integrate MCP servers (e.g., GitHub) and export configurations for development.

Includes live dashboard demos, guided UI exercises (chat/RAG/MCP with sample models), verification (response quality, tool calls), troubleshooting (e.g., tool-calling failures), and best practices for model validation. Emphasizes stateless nature (history lost on refresh) and Tech Preview limitations.

**Audience:** Data scientists, ML/AI engineers, and developers prototyping gen AI; prior model deployment and registry experience recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard (Gen AI studio enabled via admin: spec.dashboardConfig.genAiStudio: true).  
* Llama Stack Operator enabled (for full RAG/MCP support).  
* A project created with:  
  * At least one deployed model (vLLM runtime preferred, with tool-calling args like \--enable-auto-tool-choice, \--tool-call-parser, chat template).  
  * Model added as **AI asset endpoint** during deployment.  
* Optional: MCP servers configured (admin ConfigMap in redhat-ods-applications, e.g., GitHub-MCP-Server).  
* Sample documents (PDF/DOC/CSV, \<10MB each) for RAG testing.  
* Basic dashboard navigation and prompt engineering knowledge.

**Duration:** 90–120 minutes, including hands-on labs (core chat/RAG 60–80 min; MCP/export optional extension).

**Format:** Slides/overview → Live dashboard demos → Guided hands-on UI exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Create and configure Gen AI Playground instances for project-specific testing.  
* Interact with models via chat, including multi-turn conversations and parameter tuning.  
* Enable/test RAG with uploaded documents and observe context-aware responses.  
* Integrate MCP tools (if configured) and export playground setups as code templates.

### Topic 1: Overview of the Gen AI Playground and Prerequisites {#topic-1:-overview-of-the-gen-ai-playground-and-prerequisites}

**Goal:** Understand the playground's capabilities, limitations, and setup requirements.

**Core Concepts to Cover:**

* Playground: Interactive, stateless dashboard environment (Gen AI studio → Playground) for prototyping foundation/custom models, testing RAG/prompts, MCP tools, and exporting configs.  
* Core features: Chat interaction, RAG (upload docs for context), MCP integration (external tools), code export (Python template).  
* Tech Preview: No production SLAs; history lost on refresh/session end.  
* Model requirements: Tool-calling support (vLLM args: \--enable-auto-tool-choice, parser/template); larger context windows recommended.  
* Prerequisites review: Admin enables Gen AI studio/Llama Stack; user deploys model as AI asset endpoint; optional MCP ConfigMap.  
* Hands-on intro: Navigate to Gen AI studio → Playground/AI asset endpoints; verify project/models listed.

### Topic 2: Configuring a Playground Instance {#topic-2:-configuring-a-playground-instance}

**Goal:** Set up a playground tied to deployed models/endpoints.

**Core Concepts to Cover:**

* From Playground: Select project → Create playground → Dialog: Choose model(s) from AI assets, optional MCP servers.  
* From AI asset endpoints: Models tab → Add to playground for specific model.  
* Configuration: Select models, auth MCP if needed (token entry), view tools (wrench icon).  
* Verification: Playground appears in list; ready for chat.  
* Hands-on exercise: Create playground for a deployed model (e.g., Qwen or Llama variant); add MCP if available.

### Topic 3: Interacting with Models – Basic Chat and Parameter Tuning {#topic-3:-interacting-with-models-–-basic-chat-and-parameter-tuning}

**Goal:** Run chats, tune inference, and test behaviors.

**Core Concepts to Cover:**

* Chat interface: Type prompt → Send (changes to Stop during generation); toggle Streaming for real-time output.  
* Parameters: Edit **System instructions** (e.g., persona, forced tool use like "You MUST use knowledge\_search"); Temperature (0–2: deterministic to creative); New Chat to clear history.  
* Multi-turn: Maintains context within session (limited by model max tokens).  
* Hands-on: Start chat with simple prompt; adjust temperature (e.g., 0.2 vs. 1.0), add system message, observe differences; stop generation mid-response.

### Topic 4: Testing Retrieval-Augmented Generation (RAG) {#topic-4:-testing-retrieval-augmented-generation-(rag)}

**Goal:** Upload documents and validate context-aware responses.

**Core Concepts to Cover:**

* Enable RAG toggle → Upload files (PDF/DOC/CSV; max 10 files/10MB each).  
* Config: Max chunk length, chunk overlap, delimiter.  
* Query: Model uses retrieved chunks as context; test baseline vs. RAG responses.  
* Best practices: Larger context models; force tool calls in system prompt if needed.  
* Hands-on exercise: Upload sample docs (e.g., company policy PDF), query with/without RAG; compare accuracy.

### Topic 5: Integrating MCP Servers and Exporting Configurations (Optional Extension) {#topic-5:-integrating-mcp-servers-and-exporting-configurations-(optional-extension)}

**Goal:** Use external tools and transition to code development.

**Core Concepts to Cover:**

* MCP: Auth servers (e.g., GitHub), view tools, include in prompts (e.g., knowledge\_search).  
* Export: View code → Copy Python template (includes model endpoint, RAG files, MCP tools).  
* Update/Delete: Action menu → Update configuration (reselect models) or Delete playground.  
* Hands-on (if MCP configured): Auth server, test tool call in prompt; export template and discuss local iteration (e.g., in VS Code).

## Building AI/Agentic Applications with Llama Stack in Red Hat OpenShift AI 3 {#building-ai/agentic-applications-with-llama-stack-in-red-hat-openshift-ai-3}

**Description:**

Dive into Llama Stack—a unified runtime for generative AI in Red Hat OpenShift AI Self-Managed 3.2 (Technology Preview)—to build scalable RAG and agentic workflows. This hands-on session shows how to deploy the Llama Stack Operator, configure servers with inference/vector stores, ingest documents, and query via OpenAI-compatible APIs (e.g., Responses API for tool-calling/RAG).

You'll learn to:

* Activate the Llama Stack Operator and deploy LlamaStackDistribution instances.  
* Set up inference (vLLM \+ Llama models), vector databases (inline/remote Milvus/FAISS/pgvector), and metadata (PostgreSQL).  
* Use the LlamaStackClient SDK in Jupyter to register models/stores, ingest content (e.g., PDFs), and perform RAG queries (keyword/vector/hybrid search).  
* Test APIs for chat completions, embeddings, responses (with file\_search tool), and basic evaluation.

Includes live demos (CLI/dashboard/notebook), guided YAML/Python exercises, endpoint testing (curl/SDK), and best practices for dev-to-prod transitions. Perfect for teams moving from basic serving to advanced agentic/RAG applications.

**Audience:** Cluster administrators, data scientists, ML engineers, and AI developers building RAG/agent workflows; prior experience with model serving (Session 4\) and workbenches recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* oc CLI installed and authenticated as cluster admin (for Operator activation/CR creation).  
* GPU-enabled nodes (NVIDIA GPU Operator \+ NFD installed) for inference demos.  
* A data science project namespace with a workbench (Jupyter notebook).  
* Pre-deployed inference model (e.g., llama-3.2-3b-instruct via vLLM ServingRuntime from Session 4).  
* Storage connection (S3/PVC) for models/documents; optional PostgreSQL Operator for pgvector.  
* Basic YAML, Python (Jupyter), and curl knowledge.

**Duration:** 90–120 minutes, including hands-on labs (core setup/RAG 70–90 min; evaluation/agents optional extension).

**Format:** Slides/overview → Live demos (dashboard \+ CLI \+ notebook) → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Activate Llama Stack Operator and deploy/configure LlamaStackDistribution servers.  
* Set up vector stores and ingest/query documents for RAG pipelines.  
* Use OpenAI-compatible APIs (Responses, Chat Completions) in code for agentic/RAG apps.  
* Verify and test endpoints; understand provider choices (inline vs. remote) and limitations.

### Topic 1: Overview of Llama Stack and Its APIs {#topic-1:-overview-of-llama-stack-and-its-apis}

**Goal:** Understand Llama Stack's role, components, and OpenAI-compatible APIs for RAG/agent workflows.

**Core Concepts to Cover:**

* Llama Stack: Modular runtime integrating inference, embeddings, vector storage, agents, tools, evaluation, safety; managed by Llama Stack Operator via LlamaStackDistribution CR.  
* Optimized for RAG (retrieve relevant docs \+ generate) and agents (tool-calling, reasoning).  
* Key APIs: Agents, Inference (deprecated), Tool Runtime, Vector\_IO, Evaluation, Safety; OpenAI-compatible (Chat/Completions, Embeddings, Files, Vector Stores, Responses—ideal for RAG with file\_search tool).  
* Providers: Inference (remote::vllm), Vector (inline::milvus/faiss, remote::pgvector), Embeddings (sentence-transformers/nomic), etc.  
* Tech Preview note: No production SLAs; PostgreSQL mandatory for metadata in 3.2.

### Topic 2: Activating the Llama Stack Operator and Deploying a Server {#topic-2:-activating-the-llama-stack-operator-and-deploying-a-server}

**Goal:** Hands-on admin setup to enable Llama Stack in the cluster/project.

**Core Concepts to Cover:**

* Prerequisites: OpenShift 4.19+, GPU support, PostgreSQL Operator (for pgvector/prod), inference model deployed.  
* Activate Operator: Dashboard (Data Science Cluster YAML → set spec.components.llamastackoperator.managementState: Managed) or oc patch.  
* Deploy LlamaStackDistribution CR: YAML examples for inline Milvus/FAISS, remote Milvus/pgvector; env vars (VLLM\_URL, MILVUS\_ENDPOINT, ENABLE\_PGVECTOR).  
* Verification: oc get llamastackdistribution, check pods/logs in project namespace.  
* Hands-on: Patch Operator, apply sample CR (e.g., inline Milvus with vLLM connection), wait for Ready status.

### Topic 3: Deploying a RAG Stack – Vector Stores and Inference Integration {#topic-3:-deploying-a-rag-stack-–-vector-stores-and-inference-integration}

**Goal:** Build a full RAG setup with document ingestion and querying.

**Core Concepts to Cover:**

* Vector DB options: Inline Milvus/FAISS (dev/quick), remote Milvus/pgvector (prod/scalable).  
* Deploy model: Use KServe \+ vLLM runtime (e.g., llama-3.2-3b-instruct, GPU resources).  
* In Jupyter: Install llama\_stack\_client, create client (LlamaStackClient(base\_url="http://llama-stack-service:8321")), register vector store (client.vector\_stores.create(...)), ingest files (client.files.create(...), client.vector\_stores.files.create(...)).  
* Query: Use Responses API (client.responses.create(..., tools=\[{"type": "file\_search", "vector\_store\_ids": \[...\]})) for RAG; test search modes (keyword/vector/hybrid).  
* Hands-on exercise: Deploy pgvector/remote setup if available; ingest sample PDF/docs, query with/without vector store, compare outputs.

### Topic 4: Advanced RAG Features – Evaluation and Agents {#topic-4:-advanced-rag-features-–-evaluation-and-agents}

**Goal:** Explore evaluation/benchmarking and basic agentic capabilities (optional extension).

**Core Concepts to Cover:**

* Evaluation: Use Ragas (faithfulness/relevancy) or BEIR benchmarks via SDK/scripts.  
* Agents: Configure via Agents API (/v1alpha/agents), meta-reference provider; tool integration (e.g., rag-runtime).  
* Best practices: Remote providers for scale; OAuth for secure access (Keycloak integration); autoscaling/HA config.  
* Hands-on (optional): Run simple evaluation in notebook; test Responses API with tool calls.

## Customize Models to Build Generative AI Applications – Fine-Tuning and Adaptation in Red Hat OpenShift AI 3 {#customize-models-to-build-generative-ai-applications-–-fine-tuning-and-adaptation-in-red-hat-openshift-ai-3}

**Description:**

Tailor foundation models to your domain-specific needs in Red Hat OpenShift AI Self-Managed 3.2 (Technology Preview features). This hands-on session walks data scientists and ML engineers through the full customization workflow: set up specialized workbenches, process unstructured data with Docling, generate synthetic data via SDG Hub, fine-tune models using Training Hub (SFT/OSFT with distributed training), estimate GPU memory, and prepare for serving.

You'll learn to:

* Create custom workbench images/environments with Red Hat Python index packages (Docling, SDG Hub, Training Hub).  
* Convert unstructured documents to structured formats and automate via Kubeflow Pipelines.  
* Build synthetic data pipelines for knowledge tuning and augmentation.  
* Fine-tune models (SFT/OSFT) locally or distributed (multi-node via Kubeflow Trainer Operator), compare algorithms, and merge adapters.  
* Follow end-to-end examples (e.g., Knowledge Tuning for Q\&A apps).

Includes live notebook demos, guided exercises (clone repos → run flows → fine-tune sample model), verification (processed data, synthetic outputs, training logs, memory estimates), troubleshooting (disconnected envs, memory errors, timeouts), and best practices for secure, reproducible gen AI development. Integrates prior topics for production-grade model adaptation.

**Audience:** Data scientists, ML engineers, and AI developers customizing LLMs for enterprise use cases; prior workbench/pipeline/S3 experience required.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard with a project.  
* GPU-enabled nodes (NVIDIA CUDA or AMD ROCm) for fine-tuning demos (verify with nvidia-smi or node labels).  
* A workbench (custom or base with Python; recommend creating one with GPU profile).  
* Git access to clone example repos (e.g., [https://github.com/opendatahub-io/data-processing](https://github.com/opendatahub-io/data-processing)).  
* Optional: Disconnected env prep (mirrored Red Hat Python index); sample unstructured docs (PDFs/text) in S3/PVC.  
* Basic Python/Jupyter, Git, and LLM concepts.

**Duration:** 120–150 minutes, including hands-on labs (core setup/data prep/training 90–110 min; synthetic/end-to-end extension).

**Format:** Slides/overview → Live JupyterLab demos → Guided hands-on notebook exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Set up customized workbench environments with required packages and examples.  
* Process unstructured data into AI-ready formats using Docling and automate with pipelines.  
* Generate synthetic data for augmentation using SDG Hub flows.  
* Fine-tune models with Training Hub (SFT/OSFT, distributed), estimate resources, and understand performance trade-offs.

### Topic 1: Overview of Model Customization Workflow {#topic-1:-overview-of-model-customization-workflow}

**Goal:** Map the end-to-end process and understand component roles.

**Core Concepts to Cover:**

* Workflow: Environment setup → Data prep (Docling) → Synthetic generation (SDG Hub) → Fine-tuning (Training Hub: SFT for standard, OSFT for continual learning) → Serving (KServe, referenced).  
* Key tools: Docling (unstructured → structured: Markdown/chunks/extraction), SDG Hub (modular synthetic pipelines), Training Hub (fine-tuning APIs with distributed support via Kubeflow Trainer Operator/KFTO).  
* Algorithms: SFT (supervised), OSFT (orthogonal subspace for preserving base behavior; lower memory at reduced URR).  
* Distributed: KFTO abstracts multi-node scaling (memory/time savings vs. single-node).  
* Tech Preview: Components not production-supported; issues upstream.  
* Hands-on intro: Dashboard → Projects → Start workbench → JupyterLab → Clone example repos (e.g., data-processing, training-hub).

### Topic 2: Setting Up Your Working Environment {#topic-2:-setting-up-your-working-environment}

**Goal:** Prepare workbenches for customization tasks.

**Core Concepts to Cover:**

* Red Hat Python index: Secure package source (mirror in disconnected envs via wget script).  
* Custom images: Build from base (CPU/CUDA/ROCm) with index configured.  
* Installs: pip install docling, pip install sdg-hub, pip install training-hub\[cuda\] (or \[rocm\]); JupyterLab extensions if needed.  
* Import examples: Git clone repos (stable-3.0 branch) via JupyterLab Git pane or terminal.  
* Hands-on exercise: Start GPU workbench → Install packages → Clone data-processing and training-hub repos → Verify notebooks (e.g., memory\_estimator\_example.ipynb).

### Topic 3: Preparing Data with Docling {#topic-3:-preparing-data-with-docling}

**Goal:** Convert unstructured data for model input.

**Core Concepts to Cover:**

* Docling: Processes PDFs/images/text/audio → Markdown/chunks/tables/extraction.  
* Notebooks: Explore examples (conversion, chunking, info extraction); use cases (legal docs, reports).  
* Automation: Build KFP pipelines (SDK components, custom runtime images).  
* Hands-on: Run Docling notebook on sample PDF → Output structured Markdown/chunks → Optional: Build simple KFP for batch processing.

### Topic 4: Generating Synthetic Data with SDG Hub {#topic-4:-generating-synthetic-data-with-sdg-hub}

**Goal:** Augment datasets for better fine-tuning.

**Core Concepts to Cover:**

* SDG Hub: Modular flows (e.g., knowledge tuning, text analysis, Extractive Summary).  
* Performance: Benchmarks (generation times, LITELLM\_REQUEST\_TIMEOUT for endpoints).  
* Guided: Build KFP pipeline for SDG (YAML specs, components).  
* Hands-on exercise: Run SDG example notebook → Generate QA/summary pairs → View outputs/performance.

### Topic 5: Fine-Tuning Models with Training Hub {#topic-5:-fine-tuning-models-with-training-hub}

**Goal:** Adapt models using prepared/synthetic data.

**Core Concepts to Cover:**

* Training Hub: APIs for SFT/OSFT; backends (InstructLab-Training, RHAI Innovation Mini-Trainer).  
* Memory estimation: Notebook tool (estimate GPU needs based on model/params).  
* Comparison: OSFT vs. SFT (time \~2x per phase but better continual learning; memory scaling with URR).  
* Distributed: KFTO for multi-node (reduce time/resources).  
* Hands-on: Run Training Hub notebook → Fine-tune sample model (e.g., small Llama-like) with SFT/OSFT → Estimate memory → Submit distributed job if GPUs available → View logs/merged adapter.

### Topic 6: End-to-End Workflow and Best Practices {#topic-6:-end-to-end-workflow-and-best-practices}

**Goal:** Tie together for real applications and address support/limits.

**Core Concepts to Cover:**

* Knowledge Tuning example: Docling → SDG → Training Hub → KServe deployment for Q\&A app.  
* Support: Platform secure (Red Hat index); upstream for package issues.  
* Best practices: Use disconnected mirroring, estimate resources first, start small (single-node), monitor timeouts/concurrency.  
* Hands-on (optional): Follow Knowledge Tuning notebook end-to-end (data prep → fine-tune → prep for serving).

## Deploying Models on the Single-Model Serving Platform – KServe RawDeployment in Red Hat OpenShift AI 3 {#deploying-models-on-the-single-model-serving-platform-–-kserve-rawdeployment-in-red-hat-openshift-ai-3}

**Description:**

Deploy large-scale generative and predictive models efficiently on the single-model serving platform (KServe RawDeployment) in Red Hat OpenShift AI Self-Managed 3.2. This hands-on session teaches how to store models (OCI containers for performance, PVCs for simplicity), select serving runtimes (auto or manual), choose deployment strategies for resource optimization, deploy via dashboard wizard or YAML/CLI, configure accelerators/resources/auth, and verify/monitor endpoints.

You'll learn to:

* Prepare and store models in OCI images or PVCs for fast, efficient serving.  
* Use the dashboard "Deploy model" wizard for quick deployments with automatic runtime/hardware matching.  
* Deploy via CLI/YAML for repeatability and advanced control (e.g., private OCI, custom args).  
* Optimize with strategies (RollingUpdate for zero-downtime, Recreate for constrained resources), accelerators (GPU/others), and monitoring metrics.

Includes live demos (OCI build/push, dashboard wizard, YAML apply), guided exercises (store model → deploy → test inference), verification (status, URL, metrics), troubleshooting (runtime mismatches, resource headroom, pull failures), and best practices for large-model production deployment. Complements model customization and evaluation for full inference readiness.

**Audience:** Data scientists, ML engineers, and admins deploying/serving models at scale; prior project/serving/S3 experience recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard as project user (admin for runtime enabling).  
* Model serving platform and KServe enabled; preinstalled/custom runtimes available (e.g., vLLM NVIDIA, OpenVINO).  
* A project with storage connection (S3/OCI/PVC).  
* For OCI: Podman installed locally, Quay.io or similar registry access.  
* For GPUs: Enabled accelerators (NVIDIA GPU Operator \+ NFD).  
* Sample model (e.g., small ONNX/Hugging Face for testing, or large LLM URI).  
* oc CLI for YAML demos.  
* Basic YAML, Podman, and inference concepts.

**Duration:** 90–120 minutes, including hands-on labs (core wizard/YAML 70–90 min; OCI prep/monitoring extension).

**Format:** Slides/overview → Live dashboard \+ CLI demos → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Store models optimally in OCI containers or PVCs.  
* Deploy models via dashboard wizard with automatic runtime/hardware selection.  
* Use YAML/CLI for custom OCI/private deployments.  
* Choose deployment strategies, configure resources/accelerators, and monitor/verify serving endpoints.

### Topic 1: Overview of Single-Model Serving Platform and Model Storage {#topic-1:-overview-of-single-model-serving-platform-and-model-storage}

**Goal:** Understand dedicated-server deployment and storage options for efficiency.

**Core Concepts to Cover:**

* Single-model platform: KServe RawDeployment — each model on dedicated server; ideal for large/resource-heavy models (LLMs).  
* vs. other options: Distributed Inference (llm-d for scaled LLMs), NVIDIA NIM (optimized microservices).  
* Storage: S3/URI/OCI (modelcars for fast startup/low disk), PVC (simple upload via workbench).  
* OCI benefits: Pre-fetching, reduced duplication/startup time.  
* Hands-on intro: Dashboard → Projects → Deployments → Deploy model wizard overview; discuss storage choices.

### Topic 2: Preparing and Storing Models {#topic-2:-preparing-and-storing-models}

**Goal:** Hands-on model upload/prep for deployment.

**Core Concepts to Cover:**

* OCI containers: Build with Podman (temp dir, models/1 structure, Containerfile with ubi-micro, chmod, USER 65534); push to quay.io or similar.  
* PVC upload: In workbench IDE (JupyterLab/code-server) → /opt/app-root/src/ → upload files → verify.  
* Formats: ONNX (OpenVINO), Caikit, Hugging Face (URI/OCI).  
* Hands-on exercise: Build/push small ONNX model to OCI (e.g., MobileNet example); or upload files to PVC in workbench; verify paths.

**Topic 3: Deploying Models via Dashboard Wizard**

**Goal:** Quick, guided deployment with auto-features.

**Core Concepts to Cover:**

* Wizard flow: Deploy model → Model details (location/type: Predictive/Generative AI) → Model deployment (name, hardware profile, resources, runtime: auto/manual) → Advanced (AI asset endpoint, external route, token auth, custom args/vars, strategy: RollingUpdate/Recreate).  
* Auto runtime: Matches hardware/format (e.g., NVIDIA GPU → vLLM NVIDIA); manual if multiple; admin overrides (e.g., llm-d default).  
* Strategies: RollingUpdate (zero-downtime, high resources) vs. Recreate (low resources, downtime; default for llm-d).  
* Hands-on: Deploy sample model (OCI or PVC) → Select runtime/hardware → Add AI asset → Deploy → Verify status in Deployments tab.

### Topic 4: Deploying Models via YAML/CLI (Advanced Control) {#topic-4:-deploying-models-via-yaml/cli-(advanced-control)}

**Goal:** Programmatic, repeatable deployments especially for OCI/private repos.

**Core Concepts to Cover:**

* ServingRuntime: Often pre-applied (e.g., oc process kserve-ovms | oc apply for OpenVINO).  
* InferenceService YAML example (OCI public):  
  YAML

```
apiVersion: serving.kserve.io/v1beta1
kind: InferenceService
metadata:
  name: sample-isvc-oci
spec:
  predictor:
    model:
      runtime: kserve-ovms
      modelFormat:
        name: onnx
      storageUri: oci://quay.io/<user>/<repo>:<tag>
      resources:
        requests: { cpu: "100m", memory: "500Mi" }
        limits: { cpu: "500m", memory: "4Gi" }
```

* Private OCI: Add imagePullSecrets.  
* Apply: oc apply \-f isvc.yaml.  
* Hands-on exercise: Create YAML for sample OCI model → Apply → Verify with oc get inferenceservice (URL/readiness).

### Topic 5: Advanced Configurations, Verification, and Monitoring {#topic-5:-advanced-configurations,-verification,-and-monitoring}

**Goal:** Optimize and validate deployments.

**Core Concepts to Cover:**

* Resources: Requests/limits (CPU/memory/GPUs e.g., nvidia.com/gpu: "1").  
* Accelerators: Hardware profiles match runtimes (NVIDIA/AMD/Intel Gaudi/Spyre TP).  
* Advanced: Env vars/args (e.g., \--chat-template), probes (KServe defaults), token auth (service accounts), external routes.  
* Verification: Dashboard status checkmark, oc get inferenceservice (URL/conditions), test endpoint (curl with token).  
* Monitoring: Dashboard (requests/response time/utilization), OpenShift console (PromQL queries if UWM enabled).  
* Hands-on: Add GPU/resources/args to deployment → Verify metrics → Test simple inference (e.g., /v1/chat/completions).

### Topic 6: Troubleshooting and Best Practices {#topic-6:-troubleshooting-and-best-practices-1}

**Goal:** Handle common issues and production tips.

**Core Concepts to Cover:**

* Pitfalls: Runtime mismatch (manual select), insufficient headroom (RollingUpdate fails), private OCI pull secret missing, GPU operators not enabled, Recreate downtime.  
* Best practices: OCI for large models, RollingUpdate for HA, monitor quotas/metrics, test endpoints post-deploy.  
* Hands-on (optional): Simulate failure (wrong secret) → Troubleshoot via events/logs → Fix and redeploy.

## Evaluating AI Systems – Assessing LLMs and RAG Pipelines in Red Hat OpenShift AI 3 {#evaluating-ai-systems-–-assessing-llms-and-rag-pipelines-in-red-hat-openshift-ai-3}

**Description:**

Ensure trustworthy, reliable generative AI in Red Hat OpenShift AI Self-Managed 3.2 by systematically evaluating models and systems. This hands-on session covers using TrustyAI tools—**LM-Eval** for LLM benchmarking (accuracy, reasoning, toxicity), **Ragas** for RAG quality (faithfulness, relevancy, context metrics), and **Llama Stack** integrations—to run evaluations via dashboard, CLI CRDs, or notebooks. You'll configure setups, launch jobs, monitor results (logs, metrics, artifacts), compare runs, and apply best practices for quality gates and iterative improvement.

You'll learn to:

* Set up LM-Eval (global config, external access, CR properties).  
* Run LLM evaluations (dashboard form or LMEvalJob CR) on tasks/datasets (Unitxt/Hugging Face).  
* Evaluate RAG systems with Ragas (inline dev, remote production via pipelines/S3).  
* Integrate with Llama Stack for custom benchmarks/guardrails (e.g., PII detection).  
* View/compare results, interpret metrics, and troubleshoot common failures.

Includes live demos (dashboard \+ notebooks), guided exercises (create/run evaluation job → view metrics/logs), verification (status, Prometheus metrics, S3 artifacts), troubleshooting (S3 creds, online access, pod errors), and best practices for production validation. Complements fine-tuning and pipelines for evaluation-driven development.

**Audience:** Data scientists, ML engineers, MLOps teams validating gen AI models/RAG; prior model serving/customization experience recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* TrustyAI Operator enabled (admin: DataScienceCluster spec.components.trustyai.managementState: Managed).  
* Logged in to the OpenShift AI dashboard as user with project access.  
* A project with: deployed KServe model (for inference-based evals), pipeline server (for remote Ragas), optional Llama Stack enabled.  
* oc CLI for CR creation/verification; sample Hugging Face token if needed.  
* Optional: S3 connection for artifacts, custom Unitxt card JSON, or PVC for datasets.  
* Basic YAML, Python/Jupyter, and evaluation concepts (e.g., benchmarks, metrics).

**Duration:** 90–120 minutes, including hands-on labs (core LM-Eval 60–80 min; Ragas/Llama Stack extension).

**Format:** Slides/overview → Live dashboard \+ notebook demos → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Configure and run LM-Eval jobs (CLI/dashboard) for LLM tasks with custom setups.  
* Assess RAG pipelines using Ragas metrics in dev/production modes.  
* Interpret evaluation results (metrics, logs, artifacts) and compare runs for model selection.  
* Integrate basic Llama Stack evaluations and guardrails for safety checks.

### Topic 1: Overview of Evaluating AI Systems in OpenShift AI {#topic-1:-overview-of-evaluating-ai-systems-in-openshift-ai}

**Goal:** Understand evaluation tools, use cases, and TrustyAI integration.

**Core Concepts to Cover:**

* Purpose: Measure accuracy, relevance, consistency, safety (toxicity, PII) for LLMs and RAG; support iterative improvement and quality gates.  
* Tools: LM-Eval (LLM tasks via Unitxt/Hugging Face), Ragas (RAG metrics: faithfulness, answer relevancy, context precision/recall/correctness/similarity), Llama Stack (external provider, custom evals, guardrails).  
* Deployment modes: Inline (dev notebooks), remote (pipelines/S3), dashboard (Tech Preview).  
* Metrics: LM-Eval (accuracy/F1, Prometheus trustyai\_eval), Ragas (holistic RAG scores).  
* Hands-on intro: Dashboard → Develop & train → Evaluations (if enabled); verify TrustyAI pods (oc get pods \-n redhat-ods-applications).

### Topic 2: Setting Up LM-Eval for LLM Evaluations {#topic-2:-setting-up-lm-eval-for-llm-evaluations}

**Goal:** Prepare global and job-level configs for reliable runs.

**Core Concepts to Cover:**

* Global setup: Edit trustyai-service-operator-config ConfigMap (device detection, image policy, batch size).  
* External access: Enable online/remote code (CLI: patch DataScienceCluster/LMEvalJob; web console updates).  
* Properties: model (Hugging Face/local/KServe), taskList (Unitxt cards e.g., wnli), batchSize, allowOnline/allowCodeExecution, outputs (PVC/S3).  
* Security: Hugging Face token env var, SSL verification for S3.  
* Hands-on: Patch ConfigMap if needed; create sample LMEvalJob YAML (flan-t5-base \+ task); apply and verify status (oc get lmevaljob).

### Topic 3: Running and Monitoring LM-Eval Jobs {#topic-3:-running-and-monitoring-lm-eval-jobs}

**Goal:** Execute and analyze LLM evaluations.

**Core Concepts to Cover:**

* CLI: Define LMEvalJob CR (modelArgs, pod specs, custom Unitxt cards/templates/prompts); apply → monitor (oc describe/get/logs).  
* Dashboard (Tech Preview): Evaluations page → form (project/model/tasks/security); submit → view list/status.  
* Results: JSON output, Prometheus metrics, logs (last 500 lines), artifacts in PVC/S3.  
* Scenarios: KServe inference, S3 storage, LLM-as-a-Judge (custom Unitxt).  
* Hands-on exercise: Run simple job (e.g., QA task) → check status/logs → retrieve results; compare two jobs (different models/tasks).

### Topic 4: Evaluating RAG Systems with Ragas {#topic-4:-evaluating-rag-systems-with-ragas}

**Goal:** Assess retrieval \+ generation quality.

**Core Concepts to Cover:**

* Metrics: Faithfulness, answer relevancy, context precision/recall, answer correctness/similarity.  
* Modes: Inline (dev: ENABLE\_RAGAS=true in LlamaStackDistribution), remote (production: ConfigMap/secrets for S3/KFP/token).  
* Workflow: Demo notebook (basic\_demo.ipynb from llama-stack-provider-ragas repo) → run eval → view pipeline results.  
* Use cases: Quality gates, variant comparison, factual consistency.  
* Hands-on: Configure inline Ragas → run notebook eval on sample RAG pipeline → interpret scores; optional remote setup if pipeline server ready.

### Topic 5: Advanced Integrations with Llama Stack and Best Practices {#topic-5:-advanced-integrations-with-llama-stack-and-best-practices}

**Goal:** Extend evaluations and ensure robust practices.

**Core Concepts to Cover:**

* Llama Stack \+ TrustyAI: External LM-Eval provider (register benchmark, run job); custom datasets (PVC upload); guardrails (PII detection via regex shields/API).  
* Best practices: Start small (few-shot), use caching sparingly for debug, enable logSamples, compare runs via experiments.  
* Troubleshooting: S3 access (base64 secrets, endpoint), online disabled errors, pod failures (logs/events), parquet limits (s390x).  
* Hands-on (optional): Register custom benchmark → run eval; configure simple guardrail shield → test PII detection.

Here is a complete, ready-to-deliver **workshop agenda** for the topic **"Enabling AI Safety with Guardrails"** in Red Hat OpenShift AI Self-Managed 3.2, formatted in the exact style of your previous examples.

## Enabling AI Safety with Guardrails in Red Hat OpenShift AI

**Description:**

Implement robust safety controls for generative AI applications in Red Hat OpenShift AI Self-Managed 3.2 using the Guardrails framework. This hands-on session teaches how to configure and deploy guardrails to detect and block harmful content (toxicity, PII leakage, prompt injection, jailbreaking), enforce topic restrictions, validate responses, and integrate safety checks into LLM inference pipelines — all while maintaining performance and usability.

You'll learn to:

* Understand the Guardrails architecture and supported checks (toxicity, PII, jailbreak, relevance, fact-checking).  
* Install and configure the Guardrails Operator and Guardrails CRs in OpenShift AI.  
* Define custom guardrail policies (block lists, regex patterns, model-based detectors).  
* Integrate guardrails with KServe InferenceServices and vLLM runtimes.  
* Test guardrail enforcement in real-time (via Playground or API calls) and review violation logs/metrics.  
* Apply best practices for balancing safety, latency, and false positives in production.

Includes live dashboard and YAML demos, guided exercises (install operator → create guardrail policy → deploy protected model → test violations), verification steps (logs, metrics, blocked responses), troubleshooting tips (false positives, latency impact, operator health), and best practices for enterprise AI safety. Builds on model serving, playground, and inference sessions for responsible, governed generative AI deployments.

**Audience:** Data scientists, ML engineers, MLOps practitioners, security/compliance teams, and platform admins deploying generative AI; experience with OpenShift AI model serving (KServe/vLLM) and basic YAML recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard as a project user (cluster-admin helpful for operator install).  
* Model serving platform enabled with at least one deployed LLM (vLLM or similar).  
* Optional: Gen AI Playground or Playground access for quick testing.  
* Basic familiarity with KServe InferenceServices and OpenShift YAML editing.

**Duration:** 90–120 minutes, including hands-on labs (longer due to operator install and policy testing).

**Format:** Slides/overview → Live dashboard \+ YAML demos → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Install and verify the Guardrails Operator and create basic guardrail policies.  
* Configure checks for toxicity, PII, jailbreaking, and custom rules.  
* Attach guardrails to KServe InferenceServices for protected inference.  
* Test and interpret guardrail enforcement (blocked responses, violation logs).  
* Balance safety controls with model usability and performance in production.

### Topic 1: Overview of AI Safety and Guardrails in OpenShift AI

**Goal:** Understand the need for guardrails and the Guardrails framework.

**Core Concepts to Cover:**

* Risks in generative AI: toxicity, PII leakage, prompt injection, jailbreaking, hallucinations, off-topic responses.  
* Guardrails solution: pre- and post-inference checks to block or reroute harmful content.  
* Architecture: Guardrails Operator \+ Guardrail CRs \+ integration with KServe/vLLM.  
* Developer Preview status: features evolving; not production SLA.

### Topic 2: Installing and Configuring the Guardrails Operator

**Goal:** Get the operator running and ready for policy creation.

**Core Concepts to Cover:**

* OperatorHub install: Search “Guardrails” → subscribe (Technology Preview channel).  
* Verification: Pods Running in guardrails-operator namespace, CRDs available.  
* Global vs. namespace scope: cluster-wide or per-project deployment.  
* Hands-on: Subscribe → wait for operator → verify CRDs (oc get crd | grep guardrails).

### Topic 3: Creating and Applying Guardrail Policies

**Goal:** Define safety rules and attach them to models.

**Core Concepts to Cover:**

* Guardrail CR: specify checks (toxicity, pii, jailbreak, relevance, fact-check).  
* Built-in detectors: toxicity thresholds, PII regex/types, prompt injection patterns.  
* Custom rules: block lists, regex, model-based validation (e.g., another LLM as judge).  
* Attachment: Reference guardrail in InferenceService annotations or spec.  
* Hands-on exercise: Create Guardrail CR (toxicity \+ PII block) → apply to existing KServe model → verify attachment.

### Topic 4: Testing Guardrail Enforcement

**Goal:** Validate that guardrails block harmful content in real time.

**Core Concepts to Cover:**

* Test methods: Gen AI Playground, cURL to /v1/chat/completions, or notebook client.  
* Expected behavior: blocked requests return error or safe fallback; violations logged.  
* Monitoring: Guardrails metrics (Prometheus), violation logs, dashboard insights.  
* Hands-on: Send safe vs. unsafe prompts (e.g., toxic request, PII attempt) → observe block/rejection → check logs/metrics.

### Topic 5: Advanced Configuration, Tuning, and Best Practices

**Goal:** Optimize guardrails for production use.

**Core Concepts to Cover:**

* Latency impact: lightweight vs. model-based checks; tune thresholds.  
* False positives: allow lists, custom detectors, human-in-loop fallback.  
* Integration: Chain with vLLM (pre/post filters), pipelines, or RAG workflows.  
* Best practices: start strict → relax based on metrics, audit violations, combine with TrustyAI eval.  
* Hands-on: Adjust toxicity threshold → re-test → discuss trade-offs.

### Topic 6: Q\&A, Limitations, and Roadmap

**Goal:** Set expectations and discuss adoption strategy.

**Core Concepts to Cover:**

* Limitations (Developer Preview): incomplete check coverage, latency on complex detectors, evolving APIs.  
* Roadmap: more built-in detectors, tighter vLLM/KServe integration, on-cluster evaluation.  
* Discussion: Which safety risks are most critical in your use cases? How would guardrails fit your governance model?

## Working with Model Registries – Registering, Versioning, and Promoting Models in Red Hat OpenShift AI 3 {#working-with-model-registries-–-registering,-versioning,-and-promoting-models-in-red-hat-openshift-ai-3}

**Description:**

As a data scientist or AI engineer, take control of your model lifecycle using the model registry in Red Hat OpenShift AI Self-Managed 3.2. This hands-on session teaches how to register models and versions from the dashboard, enrich them with metadata (labels, descriptions, hyperparameters/metrics), deploy versions to the serving platform, track deployments/metrics, and manage archiving/restoring for clean governance.

You'll learn to:

* Register new models and add versions with storage locations (object storage or public OCI URIs).  
* Edit model/version metadata for better traceability and collaboration.  
* Deploy versions directly from the registry to production inference.  
* View/track/edit/delete deployments and archive/restore models/versions post-lifecycle.

Includes live dashboard walkthroughs, guided UI exercises (register/deploy sample models), verification steps, troubleshooting, and best practices for MLOps integration. Complements model serving (Session 4\) and admin registry setup (Session 7\) for end-to-end model promotion from workbench to production.

**Audience:** Data scientists, ML engineers, and AI practitioners registering/versioning/deploying models; cluster admins benefit from seeing user flows.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard with access to at least one model registry (granted by admin from Session 7).  
* A data science project namespace with a workbench (for optional model prep/export).  
* Sample model artifacts stored in object storage (e.g., S3 connection with bucket/path) or a public OCI URI (e.g., quay.io for testing).  
* Model serving platform enabled (from Session 4\) for deployment exercises.  
* Basic dashboard navigation and model format knowledge (e.g., ONNX, PyTorch).

**Duration:** 75–100 minutes, including hands-on labs (UI-focused keeps it concise).

**Format:** Slides/overview → Live dashboard demos → Guided hands-on UI exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Register models and versions in a registry with proper metadata and locations.  
* Edit metadata to support governance, collaboration, and searchability.  
* Deploy versions from the registry to the serving platform and track/edit/delete deployments.  
* Archive/restore models/versions for lifecycle management.

### Topic 1: Overview of Model Registries vs. Model Catalog {#topic-1:-overview-of-model-registries-vs.-model-catalog}

**Goal:** Clarify the registry's role in the model lifecycle and how it integrates with discovery/serving.

**Core Concepts to Cover:**

* Model catalog: Curated discovery/evaluation of gen AI models (Red Hat, IBM, Meta, Nvidia, etc.) with benchmarking.  
* Model registry: Central repo for custom/team models — register/version, store metadata (hyperparameters, metrics, events), share, track deployments, promote to production.  
* Workflow: Discover in catalog → experiment in workbench → register/version in registry → deploy/track → archive when obsolete.  
* Benefits: Governance, reproducibility, collaboration; metadata searchable (labels, properties).  
* Hands-on intro: Navigate dashboard → AI hub → Registry; select a registry; explore list view (sorted by last modified, searchable by name/description/labels/owner).

### Topic 2: Registering Models and Adding Versions {#topic-2:-registering-models-and-adding-versions}

**Goal:** Hands-on creation of models and iterative versioning.

**Core Concepts to Cover:**

* Register model: AI hub → Registry → Select registry → Register model → Enter model details (name, description), version details (name, description, source format e.g. ONNX, format version), location (object storage: endpoint/bucket/region/path; or public OCI URI).  
* Add version: Model details page → Versions tab → Register new version → Similar fields; auto-updates "Latest version" on Overview.  
* Verification: New model/version appears in list/Details; search/filter works.  
* Hands-on exercise: Register a sample model (use pre-stored artifact or mock location), add a second version; verify in Overview/Versions tabs.

### Topic 3: Viewing and Editing Model/Version Metadata {#topic-3:-viewing-and-editing-model/version-metadata}

**Goal:** Enrich and maintain metadata for traceability and search.

**Core Concepts to Cover:**

* Viewing: Model list → Click name → Tabs: Overview (metadata, labels, properties, latest versions/deployments), Versions (list with author/timestamps), Deployments (tracking).  
* Editing model: Overview tab → Edit labels/description/properties (key-value, e.g., license: apache, URL links auto-formatted); affects all versions.  
* Editing version: Versions tab → Click version → Edit labels/description/properties/format/format version; version-specific only.  
* Best practices: Use labels for filtering (e.g., text-to-text), properties for hyperparameters/metrics/URLs.  
* Hands-on: Edit sample metadata (add labels/properties), verify updates/searchability.

### Topic 4: Deploying and Managing Deployed Model Versions {#topic-4:-deploying-and-managing-deployed-model-versions}

**Goal:** Promote models from registry to serving and track lifecycle.

**Core Concepts to Cover:**

* Deploy: Model/Version page → Action menu (⋮) → Deploy → Wizard: Select project/connection (autofills if matching), model details/location, advanced (replicas, server size, auth, env vars/args).  
* Track/edit/delete: Deployments tab → View metrics; action menu → Edit (redeploy after changes), Delete (confirm name).  
* Integration: Deploys to model serving platform (KServe InferenceService); registry tracks deployment events.  
* Hands-on exercise: Deploy a version (use existing connection), verify in AI hub → Deployments; edit properties (e.g., replicas), delete deployment.

### Topic 5: Archiving and Restoring Models/Versions {#topic-5:-archiving-and-restoring-models/versions}

**Goal:** Handle end-of-life cleanly while preserving history.

**Core Concepts to Cover:**

* Archive: Prerequisite — delete all deployments; Model page action menu → Archive model (or version-specific); confirm name.  
* View archived: Registry page action menu → View archived models/versions.  
* Restore: Archived view action menu → Restore model/version; confirm.  
* Best practices: Archive obsolete models post-promotion; keeps history without clutter.  
* Hands-on (optional): Archive a test model/version (after deleting deployment), view archived list, restore one.

## Working with the Model Catalog – Discovering, Evaluating, Registering, and Deploying Gen AI Models in Red Hat OpenShift AI 3 {#working-with-the-model-catalog-–-discovering,-evaluating,-registering,-and-deploying-gen-ai-models-in-red-hat-openshift-ai-3}

**Description:**

Accelerate your generative AI projects by leveraging the curated model catalog in Red Hat OpenShift AI Self-Managed 3.2. This hands-on session teaches data scientists and AI engineers how to discover models from trusted providers (Red Hat, IBM, Meta, Nvidia, Mistral AI, Google), evaluate them using Red Hat-benchmarked performance metrics (latency, RPS, hardware configs), register promising models to a model registry, and deploy them directly to the serving platform—all via the intuitive dashboard.

You'll learn to:

* Navigate/search/filter the catalog and view detailed model cards.  
* Evaluate validated models via Performance Insights (benchmarks, filters for workload/latency/RPS/hardware).  
* Register models/versions to a registry for versioning and governance.  
* Deploy models with customizable runtimes, resources, and advanced settings (e.g., add as AI asset endpoint for Playground testing).

Includes live dashboard demos, guided UI exercises (discover → evaluate → register → deploy sample models), verification steps, troubleshooting, and best practices for selecting/deploying the right gen AI model. Complements model registry workflows for seamless discovery-to-production pipelines.

**Audience:** Data scientists, ML/AI engineers, and practitioners working with generative AI; cluster admins benefit from seeing end-user flows.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed.  
* Logged in to the OpenShift AI dashboard with access to the model catalog (default enabled) and at least one model registry (from admin setup in Session 7).  
* Model serving platform enabled (from Session 4\) for deployment exercises.  
* A data science project namespace for deployments.  
* Optional: Sample connection/storage ready if customizing deployments.  
* Basic dashboard navigation knowledge.

**Duration:** 75–100 minutes, including hands-on labs (UI-driven keeps it efficient).

**Format:** Slides/overview → Live dashboard demos → Guided hands-on UI exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Discover and filter models in the catalog using search, categories, and labels.  
* Evaluate models with Performance Insights benchmarks to match hardware/use case.  
* Register models from the catalog to a registry for versioning/governance.  
* Deploy models directly with optimal runtime/resources and test via AI asset endpoints.

### Topic 1: Overview of the Model Catalog and Its Role {#topic-1:-overview-of-the-model-catalog-and-its-role}

**Goal:** Understand how the catalog fits into the AI workflow and differs from the registry.

**Core Concepts to Cover:**

* Model catalog: Curated library for discovering/evaluating gen AI models (providers: Red Hat, IBM, Meta, Nvidia, Mistral AI, Google); Red Hat benchmarks third-party models on open datasets for performance/quality.  
* Benefits: Find best-fit models quickly; compare hardware-specific metrics (e.g., latency, RPS); discover before registering/deploying.  
* vs. Model registry: Catalog for upstream discovery/evaluation; registry for downstream registration/versioning/lifecycle/governance.  
* Workflow: Catalog → Evaluate → Register (to registry) → Deploy/track.  
* Hands-on intro: Navigate dashboard → AI hub → Catalog; explore categories (All models, Red Hat AI models, Red Hat AI validated models, Other models); note model cards (name, description, labels: task/provider/license/language).

### Topic 2: Searching, Filtering, and Viewing Model Details {#topic-2:-searching,-filtering,-and-viewing-model-details}

**Goal:** Efficiently discover and inspect models.

**Core Concepts to Cover:**

* Search: Use top search bar (by name/description/provider).  
* Filter: Menu for Task (e.g., text-generation), Provider, License, Language; apply/clear.  
* Categories: All/Red Hat/Validated/Other; Load more for large lists.  
* Details page: Click model → Model card (intended use, limitations, training data, eval results); tabs: Overview, Performance Insights (validated models), Versions, Deployments (post-registration/deployment).  
* Hands-on exercise: Search for "Llama" or "Mistral", filter by Provider: Meta or Task: text-generation; click a model → explore tabs/Overview.

### Topic 3: Evaluating Models with Performance Insights {#topic-3:-evaluating-models-with-performance-insights}

**Goal:** Use benchmarks to select deployment-ready models.

**Core Concepts to Cover:**

* Performance Insights tab (validated models): View Red Hat benchmarks (e.g., E2E latency, TTFT, TPS, ITL at P90 percentiles).  
* Filters: Workload type (e.g., Chatbot), Max latency threshold (slider), Min RPS, Hardware type (e.g., H200); Clear all filters.  
* Comparison: Identify configs meeting latency/RPS needs for your hardware.  
* Hands-on: Select a validated model → Performance Insights → Apply filters (e.g., latency \< 500ms, min RPS 10, hardware GPU); interpret results for deployment fit.

**Topic 4: Registering Models from the Catalog**  
**Goal:** Promote discovered models to governed registry.

**Core Concepts to Cover:**

* From model details: Click **Register model** (or from Versions tab for specific).  
* Wizard: Select registry (from available), enter name/description/format/version; location auto-filled (OCI URI for catalog models).  
* Post-registration: Model appears in AI hub → Registry (Session 8 flows).  
* Hands-on exercise: Register a sample model (e.g., Granite or Llama variant) to your test registry; verify in Registry list.

### Topic 5: Deploying Models Directly from the Catalog {#topic-5:-deploying-models-directly-from-the-catalog}

**Goal:** Move from evaluation to production inference.

**Core Concepts to Cover:**

* From model details: Click **Deploy model** → Wizard steps:  
  * Model details: Confirm type (Generative AI default), location/URI read-only.  
  * Model deployment: Project, name (autofilled), resource name (immutable later), description, hardware profile (default), CPU/memory, serving runtime (auto or manual), replicas.  
  * Advanced: Add as AI asset endpoint (for Gen AI studio/Playground testing; select use case e.g., chat), require token auth (service accounts), custom args/vars, deployment strategy (RollingUpdate default for zero-downtime).  
  * Review → Deploy.  
* Verification: Deployment in AI hub → Deployments, model details Deployments tab, Latest deployments.  
* Hands-on: Deploy a registered/discovered model (use auto runtime), add as AI asset endpoint, verify status and test endpoint if Playground available.

## Working with Machine Learning Features – Hands-On with Feature Store in Red Hat OpenShift AI 3 {#working-with-machine-learning-features-–-hands-on-with-feature-store-in-red-hat-openshift-ai-3}

### **Working with Machine Learning Features – Hands-On with Feature Store in Red Hat OpenShift AI 3** {#working-with-machine-learning-features-–-hands-on-with-feature-store-in-red-hat-openshift-ai-3-1}

**Description:**

Unlock consistent, reusable features for your ML models with Feature Store in Red Hat OpenShift AI Self-Managed 3.2 (Technology Preview). This hands-on session teaches data scientists and ML engineers how to define, organize, store, and retrieve machine learning features using the Feast-based Feature Store—ensuring feature parity between offline training and online inference, reducing duplication, and enabling collaboration across teams.

You'll learn to:

* Set up and connect to Feature Store instances from workbenches.  
* Define features, entities, data sources, and feature views in Python.  
* Apply definitions, materialize features to stores, and retrieve them for model training/inference via the Feast SDK.  
* Leverage distributed compute engines (Ray/Spark) for scalable pipelines and explore the UI for lineage and monitoring.

Build on prior workbench creation by integrating Feature Store into real ML workflows. Includes live notebook demos, guided Python/YAML exercises, verification steps, and best practices for production-grade feature engineering.

**Audience:** Data scientists, ML engineers, and MLOps practitioners building/training models; some admin familiarity helpful for initial setup verification.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed and Feature Store enabled (admin task: enable via Operator, create instance via CRD if not pre-configured).  
* oc CLI installed and access to a project namespace (e.g., oc new-project my-ml-project).  
* A workbench created (from Session 1\) with Python environment (e.g., minimal or custom image supporting pip installs).  
* Basic Python, Jupyter, and YAML knowledge.  
* Optional: Sample data source (e.g., Parquet file in PVC or accessible storage like S3) for feature definitions.

**Duration:** 90–120 minutes, including hands-on labs (adjustable; allows time for notebook exercises and troubleshooting).

**Format:** Slides/overview → Live notebook demos → Guided hands-on exercises in Jupyter → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Connect workbenches to Feature Store and verify access/RBAC.  
* Define and apply ML features/entities/views using Feast Python SDK.  
* Retrieve historical/online features for training and inference pipelines.  
* Configure basic distributed compute (e.g., Ray) and explore Feature Store UI for lineage.

### Topic 1: Overview of Machine Learning Features and Feature Store {#topic-1:-overview-of-machine-learning-features-and-feature-store}

**Goal:** Provide foundational understanding of why Feature Store matters and its core components/workflows.

**Core Concepts to Cover:**

* ML features: Measurable properties (e.g., user purchase history, credit score) used in models.  
* Feature Store (based on Feast): Centralized repo for consistency across batch (offline) training and real-time (online) inference; reduces recomputation and drift.  
* Components: Registry (metadata catalog), offline store (e.g., BigQuery/Parquet for historical), online store (e.g., Redis/PostgreSQL for low-latency serving), servers (gRPC/Arrow Flight), UI (for exploration/lineage).  
* Workflow: Define features → apply to registry → materialize to stores → retrieve via SDK.  
* Benefits: Collaboration, versioning, monitoring, integration with existing data infra.  
* Tech Preview note: Local implementation; admin enables via Operator/CRD.

### Topic 2: Configuring and Connecting to Feature Store (Workbench Integration) {#topic-2:-configuring-and-connecting-to-feature-store-(workbench-integration)}

**Goal:** Enable seamless access from workbenches (user-facing setup after admin instance creation).

**Core Concepts to Cover:**

* Admin side (quick review): Enable Feature Store component, create FeatureStore CR (apiVersion: feast.dev/v1alpha1), configure stores/PVCs/RBAC.  
* User side: In dashboard, connect workbench to Feature Store instance (mount configs to /opt/app-root/config/feast\_configs).  
* Install Feast SDK: \!pip install feast in notebook.  
* Verify: Run \!feast \--help, list features (\!feast features list), check UI access.  
* RBAC: Ensure project/user has permissions; test auth-free access in configured namespaces.

### Topic 3: Defining Machine Learning Features {#topic-3:-defining-machine-learning-features}

**Goal:** Hands-on creation of features, entities, sources, and views—the core user task.

**Core Concepts to Cover:**

* Feature definitions: Python files with Field (name, dtype, description), Entity (e.g., customer\_id join key), DataSource (batch: FileSource/Parquet; stream for online).  
* FeatureView: Groups features with schema, source, TTL, timestamp column.  
* Best practices: Timestamped data, entities for grouping, Git repo for versioned definitions.  
* Hands-on: Create Python files (e.g., driver\_stats.py), define Entity/FeatureView, run \!feast apply to sync registry.

### Topic 4: Retrieving Features for Model Training and Inference {#topic-4:-retrieving-features-for-model-training-and-inference}

**Goal:** Use retrieved features in ML workflows (training pipelines, inference).

**Core Concepts to Cover:**

* Feast SDK: Instantiate FeatureStore, use get\_historical\_features (for training DataFrame), get\_online\_features (real-time serving).  
* Materialization: Load features to stores (materialize or incremental).  
* Integration: Feed to scikit-learn/PyTorch models; support for point-in-time correct joins.  
* Hands-on: Notebook exercise—retrieve historical features as Pandas DF, train simple model; fetch online features for mock inference.

### Topic 5: Compute Engines and Advanced Pipelines (Ray/Spark) {#topic-5:-compute-engines-and-advanced-pipelines-(ray/spark)}

**Goal:** Scale feature processing with distributed engines.

**Core Concepts to Cover:**

* Engines: Local (default), Ray (distributed DAGs/transforms, configurable workers), Spark (batch processing).  
* Config: YAML in FeatureStore CR or engine specs (e.g., Ray max\_workers, join strategies).  
* Use cases: Materialize large datasets, complex transformations (joins/aggregations).  
* Optional: Explore UI for feature lineage, monitoring drifts.  
* Hands-on: Configure Ray in YAML, run distributed get\_historical\_features or materialization job.

Here’s a **structured agenda** for your **next (eleventh) workshop session**, based on the Red Hat OpenShift AI Self-Managed 3.2 documentation: **"Working with distributed workloads"** (titled "Accelerate data processing and training with distributed workloads"). This guide enables data scientists/ML engineers to run scalable, multi-node AI/ML jobs (e.g., distributed training, fine-tuning, data processing) across cluster nodes using **Kueue** for quota/queueing/scheduling, **Ray** (via CodeFlare SDK/KubeRay) for general distributed compute, and **Kubeflow Training Operator** for frameworks like PyTorch (with DDP/FSDP/LoRA support). It supports GPU/ROCm acceleration and integrates with notebooks/pipelines.

The session targets practitioners submitting and managing distributed jobs from workbenches, building on admin Kueue setup (from Session 2), model serving, and playground experimentation. Hands-on focus: Jupyter notebooks with CodeFlare SDK demos, PyTorchJob YAML submission, monitoring, and troubleshooting. Note: Some aspects (e.g., Training Operator SDK train method) are Developer Preview/Technology Preview.

## Working with Distributed Workloads – Scaling Training and Processing in Red Hat OpenShift AI 3 {#working-with-distributed-workloads-–-scaling-training-and-processing-in-red-hat-openshift-ai-3}

**Description:**

Scale your AI/ML workloads across multiple nodes in Red Hat OpenShift AI Self-Managed 3.2 for faster training, larger datasets, and complex models. This hands-on session teaches data scientists and ML engineers how to use Kueue-managed queues, submit Ray-based distributed jobs via CodeFlare SDK in Jupyter notebooks, run PyTorch fine-tuning/multi-node training (including RDMA for high-speed interconnects), monitor job status/metrics/alerts, and troubleshoot common issues.

You'll learn to:

* Set up authentication and use base training images (CUDA/ROCm).  
* Launch/manage Ray clusters interactively or via pipelines with CodeFlare SDK.  
* Create/submit PyTorchJobs (single/multi-node, LoRA/FSDP, RDMA) from notebooks or YAML.  
* View project metrics, workload status, Kueue alerts, and logs for oversight.

Includes live notebook demos, guided SDK/YAML exercises, job submission/verification, monitoring walkthroughs, and troubleshooting. Builds on workbenches and Kueue admin for production-scale distributed AI.

**Audience:** Data scientists, ML engineers, and AI practitioners running large-scale training/fine-tuning; some familiarity with notebooks, YAML, and prior sessions (workbenches, Kueue) recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift cluster with Red Hat OpenShift AI Self-Managed 3.2 installed, distributed workloads components enabled (Kueue, Ray, Training Operator via admin).  
* A workbench created (from Session 1\) with a suitable image (e.g., Standard Data Science or base training like odh-training-cuda.../py311-cu121), RWX storage (PVC), and hardware profile (GPU if available).  
* oc CLI access for token retrieval; cluster server URL and token (from OpenShift Console → ? → Copy login command).  
* Project with Kueue configured (LocalQueue/ClusterQueue/ResourceFlavors; default queue annotated if possible).  
* Optional: NVIDIA/AMD GPUs \+ RDMA setup (NicClusterPolicy) for advanced demos; Hugging Face token for model access.  
* Basic Python/Jupyter and YAML knowledge.

**Duration:** 90–120 minutes, including hands-on labs (core Ray/PyTorch submission 60–80 min; monitoring/troubleshooting extension).

**Format:** Slides/overview → Live notebook \+ dashboard demos → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Authenticate and launch Ray clusters from notebooks using CodeFlare SDK.  
* Submit and manage distributed PyTorch training jobs (single/multi-node, with accelerators).  
* Monitor distributed workloads via project metrics, status, and Kueue alerts.  
* Troubleshoot common issues like queueing failures, pod errors, or insufficient quotas.

### Topic 1: Overview of Distributed Workloads and Key Technologies {#topic-1:-overview-of-distributed-workloads-and-key-technologies}

**Goal:** Understand distributed workloads, benefits, and supported frameworks.

**Core Concepts to Cover:**

* Purpose: Run data processing/training across multiple nodes for speed/scalability; queue jobs when resources unavailable.  
* Benefits: Faster iteration, handle large datasets/complex models, efficient GPU use (e.g., NCCL DDP, FSDP, LoRA).  
* Technologies: Red Hat build of Kueue (quota/queueing/scheduling via LocalQueue/ClusterQueue/ResourceFlavor), Ray (via KubeRay/CodeFlare SDK for general distributed), Kubeflow Training Operator (PyTorch/MPI jobs).  
* Supported: Ray-based (CodeFlare SDK notebooks/pipelines), Training Operator-based (PyTorch fine-tuning/multi-GPU).  
* Hands-on intro: Navigate dashboard → Workbenches; open sample workbench; retrieve token/server URL.

### Topic 2: Preparing the Environment and Ray-Based Workloads {#topic-2:-preparing-the-environment-and-ray-based-workloads}

**Goal:** Set up workbench auth and run Ray clusters interactively.

**Core Concepts to Cover:**

* Base images: Use provided (e.g., quay.io/modh/ray:2.x-py311-cu121) or custom (extend/push to registry).  
* Auth: TokenAuthentication with server/token (expires \~24h; don't commit to Git).  
* CodeFlare SDK: Install if needed, copy demos (copy\_demo\_nbs()), configure ClusterConfiguration (namespace, image, local\_queue, workers/resources/labels).  
* Workflow: Generate TLS certs, up cluster (cluster.up()), access Ray dashboard, run jobs, down cluster.  
* Pipeline integration: Build @dsl.component with ClusterConfiguration, compile YAML.  
* Hands-on exercise: In notebook — auth.login(), create Ray cluster (update queue/image), up/down, view status/dashboard.

### Topic 3: Training Operator-Based Workloads – PyTorch Jobs {#topic-3:-training-operator-based-workloads-–-pytorch-jobs}

**Goal:** Submit fine-tuning and multi-node PyTorch training jobs.

**Core Concepts to Cover:**

* Options: YAML (PyTorchJob spec with replicas, image, command, resources incl. nvidia.com/gpu, volumes/ConfigMap for script).  
* SDK: Kubeflow Training SDK — define train\_func (SFTTrainer/LoRA), client.create\_job (job\_kind="PyTorchJob", num\_workers, resources\_per\_worker, packages).  
* RDMA (advanced): Annotations (networks), env (NCCL\_SOCKET\_IFNAME), resources (rdma/...).  
* Submission: Notebook (client.create\_job()), dashboard (YAML create PyTorchJob), or pipeline.  
* Hands-on: Create ConfigMap with training script, apply PyTorchJob YAML (multi-GPU if hardware), or use SDK for fine-tune (e.g., Llama model); monitor with get\_job\_logs().

### Topic 4: Monitoring and Viewing Distributed Workloads {#topic-4:-monitoring-and-viewing-distributed-workloads}

**Goal:** Track job progress, resources, and alerts.

**Core Concepts to Cover:**

* Project metrics: Dashboard → Metrics (CPU/memory/GPU usage for workloads).  
* Status: View workload resources (RayCluster, PyTorchJob) status/conditions.  
* Kueue alerts: Pending workloads, pod issues, quota errors.  
* Logs: oc logs, Ray dashboard, SDK methods (cluster.details(), get\_job\_logs).  
* Hands-on: Submit job, view in OpenShift Console (Pods/Jobs), check metrics/alerts, follow logs.

### Topic 5: Troubleshooting Common Problems {#topic-5:-troubleshooting-common-problems}

**Goal:** Diagnose and resolve frequent issues in distributed jobs.

**Core Concepts to Cover:**

* Common: Suspended/failed clusters (check conditions.message), queue not found (specify local\_queue), insufficient quota (view ClusterQueue), pod errors (events/logs), token expiry.  
* Tools: oc describe/get/logs, Ray status(), Kueue alerts, pod YAML.  
* Best practices: Use default queues, secure tokens, verify hardware (nvidia.com/gpu capacity).  
* Hands-on (optional): Intentionally misconfigure (wrong queue), observe error, fix and resubmit.

# Workshop for Inference-Focus Roles {#workshop-for-inference-focus-roles}

## Getting Started with Red Hat AI Inference Server – Optimized LLM Inference on Accelerators {#getting-started-with-red-hat-ai-inference-server-–-optimized-llm-inference-on-accelerators}

**Description:**

Launch high-performance, cost-optimized inference for large language models using Red Hat AI Inference Server 3.2 (vLLM-based container). This hands-on session covers pulling images, configuring environments for NVIDIA CUDA/AMD ROCm/TPU/IBM Spyre, starting the server with tensor parallelism and paged attention, serving models from Hugging Face (e.g., Llama-3.2 variants), testing inference endpoints (cURL/OpenAI-compatible), and validating performance benefits (latency/throughput reductions).

You'll learn to:

* Prepare hardware/software prerequisites and pull accelerator-specific images.  
* Run the inference server with multi-GPU support, model caching, and security options.  
* Deploy and query models (e.g., FP8/FP16 quantized) via API.  
* Troubleshoot common issues (GPU access, memory, model loading).

Includes live terminal/Podman demos, guided exercises (pull image → start server → test inference), verification (nvidia-smi/amd-smi, response latency), troubleshooting (SELinux, device perms, token errors), and best practices for production inference (shm-size, offline mode, hybrid portability). Great follow-up to OpenShift AI serving for non-Kubernetes or edge scenarios.

**Audience:** Data scientists, ML engineers, infra admins deploying standalone LLM inference; experience with containers/Podman and accelerators helpful.

**Prerequisites (cover upfront):**

* Linux server (RHEL 9.x recommended) with sudo access and Podman (or Docker) installed.  
* Accelerator hardware: NVIDIA GPU (CUDA drivers \+ Container Toolkit), AMD ROCm (MI300X+), Google TPU VM, or IBM Power/Z with Spyre.  
* registry.redhat.io access (login credentials).  
* Hugging Face account \+ token (for model downloads).  
* Sample model access (e.g., RedHatAI/Llama-3.2-1B-Instruct-FP8).  
* Optional: Multi-GPU setup for tensor parallelism demo; network access for online downloads (or offline prep).  
* Basic terminal/Podman commands.

**Duration:** 90–120 minutes, including hands-on labs (core quickstart 60–80 min; multi-GPU/troubleshooting extension).

**Format:** Slides/overview → Live terminal demos → Guided hands-on Podman exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Pull and run accelerator-specific Red Hat AI Inference Server images.  
* Start inference servers with tensor parallelism, paged attention, and model caching.  
* Test OpenAI-compatible endpoints and measure basic performance.  
* Troubleshoot hardware access, memory, and loading issues.

### Topic 1: Overview of Red Hat AI Inference Server {#topic-1:-overview-of-red-hat-ai-inference-server}

**Goal:** Understand the product, optimizations, and deployment scenarios.

**Core Concepts to Cover:**

* Purpose: Enterprise-optimized vLLM container for fast, low-cost LLM inference (continuous batching, tensor parallelism, paged attention reduce latency/costs).  
* Features: Real-time request processing, multi-GPU distribution, memory-efficient attention, OpenAI-compatible API (/v1/completions, /v1/chat/completions).  
* vs. OpenShift AI: Standalone/portable (Podman anywhere); complements KServe for dedicated/edge inference.  
* Supported accelerators: NVIDIA CUDA (T4/A100+), AMD ROCm (MI300X), Google TPU, IBM Spyre (Power/Z; FP16 only on Z).  
* Hands-on intro: podman \--version; login to registry.redhat.io.

### Topic 2: Prerequisites and Image Pulling {#topic-2:-prerequisites-and-image-pulling}

**Goal:** Set up environment and select correct image.

**Core Concepts to Cover:**

* Podman install/config; SELinux (setsebool \-P container\_use\_devices 1).  
* Accelerator prep: NVIDIA (drivers/toolkit, Fabric Manager for NVSwitch); AMD (group-add video/render); TPU (PJRT\_DEVICE=TPU); IBM (sentient group, VFIO).  
* Pull images: e.g., podman pull registry.redhat.io/rhaiis/vllm-cuda-rhel9:3.2.5 (CUDA), similar for rocm/tpu/spyre variants.  
* Cache volume: mkdir rhaiis-cache; chmod g+rwX rhaiis-cache.  
* HF token: .env file → export HF\_TOKEN=...; source it.  
* Hands-on: Pull CUDA image; verify with podman images; create cache dir; set token.

### Topic 3: Starting the Inference Server {#topic-3:-starting-the-inference-server}

**Goal:** Launch server with model and optimizations.

**Core Concepts to Cover:**

* Basic command (NVIDIA example):  
  Bash

```
podman run --rm -it \
  --device nvidia.com/gpu=all \
  --security-opt=label=disable \
  --shm-size=8g -p 8000:8000 \
  --userns=keep-id:uid=1001 \
  --env "HF_TOKEN=$HF_TOKEN" \
  -v ./rhaiis-cache:/opt/app-root/src/.cache:Z \
  registry.redhat.io/rhaiis/vllm-cuda-rhel9:3.2.5 \
  --model RedHatAI/Llama-3.2-1B-Instruct-FP8 \
  --tensor-parallel-size 2  # Match GPU count
```

* Key flags: \--tensor-parallel-size (multi-GPU), \--shm-size (large models), \--security-opt=label=disable (SELinux).  
* AMD/TPU/IBM variations: Device mounts/groups/env vars (e.g., VLLM\_SPYRE\_USE\_CB=1).  
* Hands-on exercise: Run server with sample model; monitor startup logs (model download/load); verify listening on 8000\.

### Topic 4: Testing Inference and API Usage {#topic-4:-testing-inference-and-api-usage}

**Goal:** Query the server and validate responses.

**Core Concepts to Cover:**

* OpenAI-compatible endpoints: /v1/completions or /v1/chat/completions.  
* Simple cURL test:  
  Bash

```
curl -X POST http://localhost:8000/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "RedHatAI/Llama-3.2-1B-Instruct-FP8",
    "prompt": "What is the capital of France?",
    "max_tokens": 50
  }' | jq
```

* Advanced: Streaming, chat templates, batching benefits.  
* Hands-on: Run multiple queries; compare latency with/without tensor parallelism; test chat format.

### Topic 5: Performance Validation and Troubleshooting {#topic-5:-performance-validation-and-troubleshooting}

**Goal:** Measure optimizations and fix common problems.

**Core Concepts to Cover:**

* Validate: Throughput (requests/sec), latency reduction via paged attention/continuous batching; tools like nvidia-smi/amd-smi during load.  
* Common issues: GPU not detected (driver/toolkit), OOM (increase shm-size), model download fail (offline mode/pre-download), SELinux denials.  
* Best practices: Offline caching, multi-GPU sizing, monitor costs (lower via paged attention).  
* Hands-on (optional): Stress test with concurrent curls → observe batching; simulate error (wrong device) → troubleshoot logs.

## Deploying Red Hat AI Inference Server in a Disconnected Environment – Air-Gapped Inference in OpenShift {#deploying-red-hat-ai-inference-server-in-a-disconnected-environment-–-air-gapped-inference-in-openshift}

**Description:**

Deploy and serve LLMs securely in fully disconnected/air-gapped OpenShift clusters using Red Hat AI Inference Server 3.2 (vLLM-optimized). This hands-on session covers setting up a bastion mirror registry, mirroring required images (server, models, NFD/GPU Operators), installing Operators from the mirror, configuring persistent model storage (NFS/PVC), creating Deployment/Service/Route resources, and testing offline inference with OpenAI-compatible endpoints.

You'll learn to:

* Prepare a bastion host and mirror images to a private registry for disconnected access.  
* Install NFD and NVIDIA GPU Operators using mirrored catalogs.  
* Deploy the inference server with GPU resources, tensor parallelism, and cached models.  
* Expose and test inference in a restricted network (no internet).

Includes live oc \+ bastion demos, guided YAML exercises (ImageSetConfiguration, Subscriptions, Deployment), verification (mirroring success, Operator pods, GPU allocation, curl tests), troubleshooting (mirror failures, Operator install from mirror, PVC mounting, device detection), and best practices for secure, offline production inference. Complements connected deployments for high-security or edge scenarios.

**Audience:** Cluster administrators, DevOps/SecOps engineers, and ML practitioners in air-gapped environments; prior OCP mirroring experience and NVIDIA hardware recommended.

**Prerequisites (cover upfront):**

* Disconnected OpenShift Container Platform cluster (4.14–4.19) with cluster-admin access.  
* Bastion host (with internet) running RHEL/Podman/oc CLI.  
* Private mirror registry (e.g., quay.io or internal) accessible from cluster.  
* registry.redhat.io credentials for initial pulls on bastion.  
* NVIDIA GPUs in cluster nodes (CUDA-capable).  
* Test namespace (e.g., rhaiis-namespace).  
* Sample model (e.g., Granite quantized) accessible via Hugging Face on bastion.  
* Optional: NFS server for PVC backend; Hugging Face token.  
* Basic YAML, mirroring (oc mirror), and disconnected concepts.

**Duration:** 120–150 minutes, including hands-on labs (mirroring/Operators 60–80 min; deployment/testing 50–60 min).

**Format:** Slides/overview → Live bastion \+ oc demos → Guided hands-on YAML exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Set up and use a mirrored registry for disconnected image pulls.  
* Mirror and install NFD/GPU Operators in air-gapped OCP.  
* Deploy Red Hat AI Inference Server with persistent model storage and GPU resources.  
* Test and verify offline model inference endpoints.

### Topic 1: Overview of Disconnected Deployment and Air-Gapped Constraints {#topic-1:-overview-of-disconnected-deployment-and-air-gapped-constraints}

**Goal:** Understand differences from connected setups and high-level flow.

**Core Concepts to Cover:**

* Disconnected/air-gapped: No direct internet; all images pulled via bastion mirror registry; only NVIDIA CUDA supported (no AMD/TPU/IBM).  
* Flow: Bastion → mirror images (server \+ models \+ Operators) → configure cluster to use mirror → install NFD/GPU Operators from mirror → deploy server with PVC → test inference.  
* Benefits: Secure isolation, compliance; uses oc mirror v2alpha1 for ImageSetConfiguration.  
* Limitations: Internet required on bastion; manual approval for some Operators; NFS or similar for persistent models.  
* Hands-on intro: On bastion: podman login registry.redhat.io; verify oc login to cluster.

### Topic 2: Setting Up the Mirror Registry on Bastion Host {#topic-2:-setting-up-the-mirror-registry-on-bastion-host}

**Goal:** Create and configure the disconnected mirror.

**Core Concepts to Cover:**

* Bastion role: Internet gateway for pulling from registry.redhat.io → push to private mirror (e.g., registry.example.com:5000).  
* Steps: Install Podman/oc, create mirror registry (per OCP disconnected install guide), add pull secret credentials.  
* Hands-on: Follow linked OCP guide to set up mirror; test pull/push a test image.

### Topic 3: Mirroring Required Images {#topic-3:-mirroring-required-images}

**Goal:** Cache server, model, and Operator images.

**Core Concepts to Cover:**

* Images to mirror: rhaiis/vllm-cuda-rhel9 (server), model (e.g., rhelai1/granite-...-w8a8), ose-cluster-nfd-operator, nvidia/gpu-operator-bundle.  
* ImageSetConfiguration YAML: Define operators (NFD/GPU) \+ additionalImages (server/model).  
* Mirror command: oc mirror \--config imageset-config.yaml docker://\<mirror-registry\> \--registry-config \<pull-secret.json\>.  
* Cluster config: Update imageContentSourcePolicy to point to mirror.  
* Hands-on exercise: Create imageset-config.yaml (full with Operators or minimal additionalImages) → run mirror → verify mirrored images in private registry.

### Topic 4: Installing NFD and NVIDIA GPU Operators from Mirror {#topic-4:-installing-nfd-and-nvidia-gpu-operators-from-mirror}

**Goal:** Enable accelerator detection/drivers in disconnected mode.

**Core Concepts to Cover:**

* NFD: Namespace (openshift-nfd), OperatorGroup, Subscription (source: redhat-operators mirrored).  
* NVIDIA GPU: Namespace (nvidia-gpu-operator), OperatorGroup, Subscription (certified-operators mirrored; manual approval).  
* Verification: oc get pods \-n openshift-nfd and \-n nvidia-gpu-operator; node labels (oc get nodes \-o json | grep nvidia.com/gpu).  
* Hands-on: Apply CRs for NFD → verify; apply GPU Subscription → approve InstallPlan → wait for pods → check node labels/GPU capacity.

### Topic 5: Deploying the Inference Server and Serving a Model {#topic-5:-deploying-the-inference-server-and-serving-a-model}

**Goal:** Hands-on deployment with persistent storage.

**Core Concepts to Cover:**

* PVC: Create for model storage (e.g., NFS-backed, claimName: granite-31-w8a8).  
* Deployment CR: vLLM image from mirror (sha digest), resources (nvidia.com/gpu: "1"), args (--model=/mnt/models \--tensor-parallel-size=1), volumeMounts (PVC \+ /dev/shm for NCCL).  
* Service: ClusterIP port 80 → target 8000\.  
* Route: Expose externally (optional passthrough).  
* Model prep: Pre-download/cache model to PVC (via init container or manual copy).  
* Hands-on exercise: Apply PVC → Deployment YAML (Granite example) → Service → Route → Get route URL → scale replicas=1 → verify pods Running.

### Topic 6: Testing Inference and Troubleshooting {#topic-6:-testing-inference-and-troubleshooting}

**Goal:** Validate offline serving and resolve issues.

**Core Concepts to Cover:**

* Test: cURL to Route /v1/chat/completions (model name from args).  
* Monitoring: oc logs, OCP console metrics, nvidia-smi via debug pod.  
* Troubleshooting: Mirror pull fails (check ImageContentSourcePolicy), Operator not from mirror (subscription source wrong), pod CrashLoop (missing /dev/shm, PVC mount fail), GPU not allocated (labels missing).  
* Best practices: Use digests for images, encrypt NFS, secure Routes, monitor quotas.  
* Hands-on: Run inference curl → check response; simulate failure (wrong GPU limit) → troubleshoot events/logs → fix.

## Deploying Red Hat AI Inference Server in OpenShift Container Platform – Accelerator-Optimized Inference in OCP Clusters {#deploying-red-hat-ai-inference-server-in-openshift-container-platform-–-accelerator-optimized-inference-in-ocp-clusters}

**Description:**

Deploy and serve large language models at scale using Red Hat AI Inference Server (vLLM-optimized) directly in OpenShift Container Platform clusters with NVIDIA or AMD accelerators. This hands-on session covers installing prerequisite Operators (NFD \+ GPU-specific), configuring secrets and storage, creating Deployment/Service/Route resources, loading models (e.g., Granite or Llama variants), and testing inference endpoints.

You'll learn to:

* Install and verify NFD and NVIDIA/AMD GPU Operators for accelerator detection and drivers.  
* Set up required secrets (Hugging Face token, Docker pull) and PVCs for model persistence.  
* Deploy the inference server as a Kubernetes Deployment with GPU resources and tensor parallelism.  
* Expose the service via Route and validate inference with OpenAI-compatible API calls.

Includes live oc demos, guided YAML exercises (Operator subscriptions, Deployment CRs), verification (pods, node labels, GPU allocation, curl tests), troubleshooting (Operator install failures, device detection, memory issues), and best practices for production (monitoring, scaling, security). Builds on standalone Podman deployment for cluster-integrated inference scenarios.

**Audience:** Cluster administrators, DevOps engineers, and ML engineers managing inference in OpenShift; prior OCP CLI experience and accelerator hardware recommended.

**Prerequisites (cover upfront):**

* Access to an OpenShift Container Platform cluster (4.14–4.19 supported) with cluster-admin privileges.  
* oc CLI installed and logged in as cluster-admin.  
* Supported accelerators: NVIDIA GPUs (CUDA drivers) or AMD GPUs (ROCm MI300X+); full internet access required (not disconnected).  
* registry.redhat.io login credentials (for image pulls).  
* Hugging Face token for model access.  
* A test namespace/project (e.g., rhaiis-namespace).  
* Optional: Pre-existing model in Hugging Face or local cache.  
* Basic YAML and OpenShift concepts.

**Duration:** 90–120 minutes, including hands-on labs (Operator installs 40–50 min; deployment/testing 40–60 min).

**Format:** Slides/overview → Live oc \+ dashboard demos → Guided hands-on YAML exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Install NFD and accelerator Operators to enable GPU/ROCm detection in OCP.  
* Configure secrets, storage, and Deployments for Red Hat AI Inference Server.  
* Deploy and expose inference services with GPU resources.  
* Test and verify model serving endpoints in cluster.

### Topic 1: Overview of Red Hat AI Inference Server in OpenShift {#topic-1:-overview-of-red-hat-ai-inference-server-in-openshift}

**Goal:** Understand integration benefits and prerequisites.

**Core Concepts to Cover:**

* Red Hat AI Inference Server: vLLM container optimized for low-latency/high-throughput LLM inference; portable to OCP for managed clusters with accelerators.  
* vs. standalone Podman: Cluster-native scaling, monitoring (Prometheus), Routes for exposure, Operator-managed drivers.  
* vs. OpenShift AI KServe: Direct vLLM control, potentially lower overhead for dedicated inference nodes.  
* Prerequisites: Internet access, cluster-admin, supported GPUs (NVIDIA/AMD).  
* Hands-on intro: Verify cluster version (oc version), accelerator nodes (oc get nodes \-o wide), registry login.

### Topic 2: Installing Prerequisite Operators – NFD and GPU Drivers {#topic-2:-installing-prerequisite-operators-–-nfd-and-gpu-drivers}

**Goal:** Enable hardware detection and drivers.

**Core Concepts to Cover:**

* Node Feature Discovery (NFD): Detects accelerators → labels nodes (e.g., feature.node.kubernetes.io/nvidia.com/gpu).  
* NVIDIA GPU Operator: Installs drivers/toolkit/device-plugin (CUDA).  
* AMD GPU Operator: Installs ROCm drivers (MI300X+; requires KMM, blacklist amdgpu module, DeviceConfig).  
* CRs: Namespace, OperatorGroup, Subscription (redhat-operators/certified-operators).  
* Verification: Pods Running, node labels (oc get node \-o json | grep gpu).  
* Hands-on exercise: Apply NFD CRs → verify pods; install NVIDIA/AMD Operator (choose one) → wait for validation pods → check node labels (amd.com/gpu or nvidia.com/gpu).

### Topic 3: Preparing Secrets, Storage, and Namespace {#topic-3:-preparing-secrets,-storage,-and-namespace}

**Goal:** Set up access and persistence.

**Core Concepts to Cover:**

* Namespace: Create dedicated (e.g., rhaiis-namespace).  
* Secrets: Hugging Face token (oc create secret generic hf-secret \--from-literal=HF\_TOKEN=...), Docker config for pulls.  
* PVC: For model cache/persistence (ReadWriteOnce, sufficient size).  
* Hands-on: Create namespace → secrets → PVC YAML apply → verify (oc get pvc).

### Topic 4: Deploying the Inference Server and Serving a Model {#topic-4:-deploying-the-inference-server-and-serving-a-model}

**Goal:** Hands-on deployment and exposure.

**Core Concepts to Cover:**

* Deployment CR: Use vLLM image (e.g., registry.redhat.io/rhaiis/vllm-cuda-rhel9:3.2.x), GPU resources (nvidia.com/gpu: "2" or amd.com/gpu: "1"), env (HF\_TOKEN from secret), volumeMounts (PVC), args (--model \<hf-repo\> \--tensor-parallel-size \<gpu-count\>).  
* Service: ClusterIP or LoadBalancer on port 8000\.  
* Route: Expose externally (passthrough TLS if needed).  
* Model loading: From Hugging Face (online) or pre-cached.  
* Hands-on exercise: Apply Deployment YAML (sample Granite/Llama) → Service → Route → Get route URL → Verify pods (oc get pods \-w).

### Topic 5: Testing Inference and Monitoring {#topic-5:-testing-inference-and-monitoring}

**Goal:** Validate serving and observe performance.

**Core Concepts to Cover:**

* API test: cURL to /v1/chat/completions or /v1/completions (OpenAI-compatible).  
* Monitoring: OCP console (pods, metrics), nvidia-smi/amd-smi via debug pod, Prometheus if enabled.  
* Scaling: Replicas, tensor parallelism for multi-GPU.  
* Hands-on: Curl test with prompt → check response latency → scale Deployment → re-test.

### Topic 6: Troubleshooting and Best Practices {#topic-6:-troubleshooting-and-best-practices-2}

**Goal:** Resolve issues and optimize production use.

**Core Concepts to Cover:**

* Common: GPU not allocated (check node labels, resources), model download fail (internet/proxy), pod CrashLoop (logs: oc logs), SELinux/permissions.  
* Best practices: Use PVC caching, monitor quotas, secure Routes (TLS), start small (single GPU), integrate with OpenShift AI for hybrid workflows.  
* Hands-on (optional): Simulate issue (missing secret) → troubleshoot events/logs → fix.

## Inference Serving Language Models in OCI-Compliant Model Containers – Modelcars for Efficient Deployment in Red Hat AI Inference Server 3 {#inference-serving-language-models-in-oci-compliant-model-containers-–-modelcars-for-efficient-deployment-in-red-hat-ai-inference-server-3}

**Description:**

Optimize language model distribution and inference with OCI-compliant model containers (modelcars) in Red Hat AI Inference Server 3.2. This hands-on session teaches how to package models from Hugging Face into lightweight OCI images, push them to registries, serve them locally via Podman on GPU hardware, and deploy them in OpenShift clusters using Deployment CRs, initContainers for model pull, persistent storage, and Route exposure.

You'll learn to:

* Build multi-stage modelcar images with model downloads and minimal footprint.  
* Push images to private registries and serve locally with tensor parallelism and offline mode.  
* Deploy modelcars in OCP with GPU resources, shared memory, and caching.  
* Test OpenAI-compatible inference endpoints and verify performance benefits (startup time, disk usage).

Includes live Podman/oc demos, guided exercises (build modelcar → local serve → OCP deployment → API testing), verification (image layers, pod status, GPU allocation, curl responses), troubleshooting (pull failures, SELinux, shm-size, initContainer errors), and best practices for production (digests, security scanning, multi-GPU). Complements previous inference sessions for registry-native, portable model serving.

**Audience:** ML engineers, DevOps admins, and inference specialists optimizing model delivery; prior Podman/OCP experience and GPU access recommended.

**Prerequisites (cover upfront):**

* Linux server or OpenShift cluster with NVIDIA GPUs (CUDA drivers \+ Container Toolkit installed).  
* Podman (local) and oc CLI (cluster); registry.redhat.io and private registry (e.g., Quay.io) access.  
* Python 3.11+ and huggingface\_hub for model download script.  
* Hugging Face token for model pulls.  
* Test namespace in OCP (for cluster part).  
* Optional: Multi-GPU setup for tensor parallelism; sample model repo (e.g., ibm-granite/granite-3.1-2b-instruct).  
* Basic Podman, Dockerfile, and YAML knowledge.

**Duration:** 90–120 minutes, including hands-on labs (build/push/local serve 50–70 min; OCP deployment/testing 40–50 min).

**Format:** Slides/overview → Live Podman \+ oc demos → Guided hands-on exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Build and push OCI modelcar images from Hugging Face models.  
* Serve modelcars locally via Podman with GPU optimizations and offline mode.  
* Deploy modelcars in OpenShift using Deployment CRs, PVCs, and initContainers.  
* Test and validate inference endpoints with reduced startup time and disk usage.

### Topic 1: Overview of OCI-Compliant Model Containers (Modelcars) {#topic-1:-overview-of-oci-compliant-model-containers-(modelcars)}

**Goal:** Understand benefits and workflow vs. traditional storage.

**Core Concepts to Cover:**

* Modelcars: OCI images packaging models (e.g., safetensors, json, txt) for registry distribution; enable versioning, caching, security scanning, unified workflows.  
* Benefits: Faster startup (pre-fetch), lower disk usage (layers), better performance/security over S3/URI/PVC.  
* Workflow: Build multi-stage image → push to registry → mount/serve locally (Podman) or in OCP (Deployment \+ initContainer pull).  
* Supported: Hugging Face models; NVIDIA CUDA focus (multi-GPU tensor parallelism).  
* Hands-on intro: Discuss layers (Podman inspect), compare startup time vs. direct HF download.

### Topic 2: Building and Pushing a Modelcar Image {#topic-2:-building-and-pushing-a-modelcar-image}

**Goal:** Hands-on packaging of a model into OCI format.

**Core Concepts to Cover:**

* Setup: Python venv, pip install huggingface\_hub, download script (snapshot\_download with patterns).  
* Dockerfile: Multi-stage (base: ubi9/python-311 for download → final: ubi-micro copy /models).  
* Build: podman build . \-t modelcar-granite:latest \--platform linux/amd64.  
* Push: podman push quay.io/\<user\>/modelcar-granite:latest.  
* Hands-on exercise: Create venv/script/Dockerfile → build → push sample model (e.g., granite-3.1-2b-instruct) → verify in registry.

### Topic 3: Serving Modelcars Locally with Podman {#topic-3:-serving-modelcars-locally-with-podman}

**Goal:** Run inference server mounting the modelcar image.

**Core Concepts to Cover:**

* Pull server image: podman pull registry.redhat.io/rhaiis/vllm-cuda-rhel9:3.2.x.  
* SELinux/cache: setsebool container\_use\_devices 1, create rhaiis-cache dir.  
* Run command: \--mount type=image,source=\<modelcar\>,destination=/model \+ offline env vars (HF\_HUB\_OFFLINE=1, TRANSFORMERS\_OFFLINE=1), \--model /model/models, \--tensor-parallel-size \<gpu-count\>, \--shm-size=8g, \--userns=keep-id:uid=1001.  
* Hands-on: Start server with mounted modelcar → monitor logs (model load) → verify nvidia-smi allocation.

### Topic 4: Deploying Modelcars in OpenShift Container Platform {#topic-4:-deploying-modelcars-in-openshift-container-platform}

**Goal:** Cluster-native deployment with persistent caching.

**Core Concepts to Cover:**

* Secrets: Docker config for private registry pulls (oc create secret generic docker-secret).  
* PVC: For model cache (e.g., 20Gi, ReadWriteOnce).  
* Deployment CR: InitContainer (oras pull to /model if empty), main container (vLLM image from digest, GPU resources, volumeMounts for PVC \+ /dev/shm emptyDir Memory).  
* Service/Route: ClusterIP → Route for external access.  
* Scale: oc scale deployment \--replicas=1.  
* Hands-on exercise: Create namespace/secrets/PVC → apply Deployment/Service/Route YAML → wait for Ready → get Route URL.

### Topic 5: Testing Inference and Verification {#topic-5:-testing-inference-and-verification}

**Goal:** Validate serving and measure benefits.

**Core Concepts to Cover:**

* API test: cURL to /v1/chat/completions or /v1/completions (model name from args).  
* Verification: Pod logs (model load), oc describe pod (GPU allocation), metrics (latency/throughput).  
* Benefits demo: Compare startup time vs. non-modelcar (pre-mount vs. download).  
* Hands-on: Run inference queries → jq parse responses → check GPU utilization.

### Topic 6: Troubleshooting and Best Practices {#topic-6:-troubleshooting-and-best-practices-3}

**Goal:** Handle common issues and optimize.

**Core Concepts to Cover:**

* Issues: Pull failures (secret wrong, digest mismatch), initContainer errors (oras auth), shm-size OOM (increase emptyDir), GPU not mounted (resources missing).  
* Best practices: Use image digests, encrypt registry access, secure Routes (TLS), monitor PVC usage, start with small models.  
* Hands-on (optional): Simulate pull error → troubleshoot events/logs → fix secret → redeploy.

## vLLM Server Arguments – Fine-Tuning Inference Performance and Behavior in Red Hat AI Inference Server 3 {#vllm-server-arguments-–-fine-tuning-inference-performance-and-behavior-in-red-hat-ai-inference-server-3}

**Description:**

Master the extensive configuration options of the vLLM engine powering Red Hat AI Inference Server 3.2. This hands-on session explores the most impactful server arguments and environment variables for controlling model loading, inference quality, throughput, memory usage, multi-GPU scaling, quantization, LoRA adapters, logging, and OpenAI-compatible API behavior—whether running standalone via Podman or as an OpenShift Deployment.

You'll learn to:

* Tune core inference parameters (temperature, top-p/top-k, max tokens, repetition penalty) for output quality vs. creativity.  
* Optimize engine performance (tensor parallelism, paged attention, continuous batching, GPU memory fraction).  
* Enable advanced features (quantization types, LoRA support, chat templates, guided decoding).  
* Customize logging, endpoints, and security (CORS, API keys) for production use.  
* Benchmark and compare configurations (latency, tokens/sec, GPU utilization).

Includes live Podman/oc demos, guided exercises (modify args → restart server → test endpoints → measure performance), verification (logs, nvidia-smi, response quality), troubleshooting (OOM, invalid args, quantization mismatches), and best practices for production tuning (start conservative, monitor metrics, combine flags wisely). Perfect capstone for inference server series, enabling optimized, reproducible deployments.

**Audience:** ML engineers, inference optimization specialists, and platform admins tuning LLM serving; prior experience running the inference server (Podman or OCP) strongly recommended.

**Prerequisites (cover upfront):**

* Running Red Hat AI Inference Server instance (Podman on GPU server or OCP Deployment from previous sessions).  
* NVIDIA GPU(s) with CUDA drivers/toolkit (for most flags; some CPU-only options available).  
* Podman (local) or oc CLI (cluster); access to a test model (e.g., Llama-3.2, Granite, or quantized variant).  
* Tools for benchmarking: cURL, jq, watch/nvidia-smi (or amd-smi).  
* Optional: Multi-GPU setup, LoRA adapter files, custom chat template JSON.  
* Basic understanding of LLM inference concepts (sampling, quantization, parallelism).

**Duration:** 90–120 minutes, including hands-on labs (core args \+ benchmarking 70–90 min; advanced features extension).

**Format:** Slides/overview → Live command/Deployment edits → Guided hands-on experiments → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Tune inference quality and diversity using sampling and generation parameters.  
* Maximize throughput and reduce latency with engine optimizations (tensor parallelism, paged attention, batching).  
* Apply quantization, LoRA, and multi-GPU scaling for memory efficiency and performance.  
* Customize logging, API behavior, and security for production-grade inference.

### Topic 1: Overview of vLLM Server Arguments and Key Categories {#topic-1:-overview-of-vllm-server-arguments-and-key-categories}

**Goal:** Map the argument landscape and prioritize high-impact flags.

**Core Concepts to Cover:**

* Categories: Model loading (--model, \--tokenizer, \--dtype, \--quantization), Engine/Performance (--tensor-parallel-size, \--gpu-memory-utilization, \--max-model-len, \--enforce-eager), Generation (--temperature, \--top-p, \--top-k, \--max-tokens, \--repetition-penalty), API (--host, \--port, \--api-key, \--cors-allow-origins), Advanced (LoRA: \--lora-modules, guided decoding, chat templates), Logging (--log-level, \--log-requests).  
* Environment variables: HF\_TOKEN, VLLM\_WORKER\_MULTIPROC\_METHOD (for multi-GPU stability).  
* Defaults & overrides: Many have sensible defaults; args take precedence over env vars.  
* Hands-on intro: Review running command (Podman or Deployment args) → identify current flags.

### Topic 2: Core Model Loading and Quantization Arguments {#topic-2:-core-model-loading-and-quantization-arguments}

**Goal:** Control model format, precision, and memory footprint.

**Core Concepts to Cover:**

* \--model \<hf-repo-or-local-path-or-modelcar\>  
* \--dtype (auto, float16, bfloat16, float32)  
* \--quantization (awq, gptq, fp8, squeezellm, marlin, bitsandbytes)  
* \--max-model-len (context window override)  
* \--trust-remote-code (for custom models)  
* Hands-on: Restart server with \--quantization fp8 (if model supports) or \--dtype bfloat16 → compare memory usage (nvidia-smi) and startup time.

### Topic 3: Performance & Multi-GPU Optimizations {#topic-3:-performance-&-multi-gpu-optimizations}

**Goal:** Maximize throughput and minimize latency on accelerators.

**Core Concepts to Cover:**

* \--tensor-parallel-size \<num-gpus\> (distribute layers)  
* \--gpu-memory-utilization (0.0–1.0; default \~0.9)  
* \--max-num-seqs / \--max-num-batched-tokens (batching control)  
* \--enforce-eager (disable CUDA graphs for stability/debug)  
* \--enable-chunked-prefill (for very long prompts)  
* \--disable-log-stats (reduce overhead)  
* Hands-on exercise: Run with/without \--tensor-parallel-size 2 (multi-GPU) → send concurrent requests → compare tokens/sec and latency.

### Topic 4: Generation & Sampling Parameters {#topic-4:-generation-&-sampling-parameters}

**Goal:** Balance creativity, coherence, and determinism.

**Core Concepts to Cover:**

* \--temperature (0.0 deterministic → higher creative)  
* \--top-p / \--top-k (nucleus/top-k sampling)  
* \--max-tokens / \--min-tokens  
* \--repetition-penalty / \--length-penalty  
* \--seed (reproducibility)  
* Chat template: \--chat-template (path to jinja or auto)  
* Hands-on: Test same prompt with temperature 0.0 vs. 1.0, top-p 0.9 vs. 1.0 → observe diversity/coherence.

### Topic 5: API Customization, LoRA, Logging, and Advanced Features {#topic-5:-api-customization,-lora,-logging,-and-advanced-features}

**Goal:** Production-ready tweaks and extensions.

**Core Concepts to Cover:**

* \--host 0.0.0.0 \--port 8000  
* \--api-key (require auth)  
* \--cors-allow-origins "\*"  
* LoRA: \--lora-modules \<name\>= (multiple adapters)  
* \--guided-decoding-backend (outlines, guidance)  
* Logging: \--log-level DEBUG, \--log-requests  
* Hands-on (optional): Add \--api-key → test with Authorization header; load LoRA adapter if available → switch adapters in requests.

### Topic 6: Benchmarking, Troubleshooting, and Best Practices {#topic-6:-benchmarking,-troubleshooting,-and-best-practices}

**Goal:** Measure impact and resolve common misconfigurations.

**Core Concepts to Cover:**

* Benchmarking: Concurrent curls, measure TTFT/tokens-per-sec, GPU util.  
* Troubleshooting: Invalid arg (check logs), OOM (lower gpu-memory-util or max-model-len), quantization mismatch (model not compatible), multi-GPU hang (VLLM\_WORKER\_MULTIPROC\_METHOD=ray).  
* Best practices: Start with defaults → tune one category at a time, monitor with nvidia-smi/watch, use \--seed for reproducible tests, prefer modelcars for caching.  
* Hands-on: Run baseline → apply 3–4 key changes → re-benchmark → discuss trade-offs.

## Red Hat AI Model Optimization Toolkit – Compressing & Quantizing LLMs for Efficient Inference {#red-hat-ai-model-optimization-toolkit-–-compressing-&-quantizing-llms-for-efficient-inference}

**Description:**

Reduce memory usage, latency, and costs while preserving model quality using the Red Hat AI Model Optimization Toolkit (Developer Preview) in Red Hat AI Inference Server 3.2. This hands-on session covers installing/running the toolkit container, applying quantization/sparsity recipes (AWQ/GPTQ/FP8/NVFP4, SparseGPT, transforms), handling calibration data, supporting multimodal/MoE models, generating compressed-tensors outputs, and serving optimized models with vLLM for inference gains.

You'll learn to:

* Pull and run the rhaiis/model-opt-cuda-rhel9 container on GPU hardware.  
* Execute example recipes (e.g., INT8 w8a8 on Llama-3, FP8 block quantization).  
* Customize compression (multi-compressor, transforms, sparsity skip).  
* Integrate outputs with Red Hat AI Inference Server (local/OCP) and validate performance (memory reduction, throughput).

Includes live Podman demos, guided exercises (clone LLM Compressor examples → run quantization → serve optimized model), verification (compression logs, model size comparison, inference benchmarks), troubleshooting (GPU access, calibration failures, unsupported models), and best practices for production compression (start small, use calibration datasets, combine with vLLM args). Complements modelcar/model serving sessions for end-to-end optimized inference pipelines.

**Audience:** ML engineers, inference optimization specialists, and AI platform admins focusing on cost/performance; prior experience with Red Hat AI Inference Server (Podman/OCP) and Hugging Face models required.

**Prerequisites (cover upfront):**

* Linux server with NVIDIA GPU(s) (CUDA drivers \+ Container Toolkit installed).  
* Podman installed; sudo access; SELinux configured (setsebool \-P container\_use\_devices 1).  
* registry.redhat.io login credentials.  
* Hugging Face account \+ token (HF\_TOKEN) for model access (request approval for gated models like Llama-3).  
* Working directory with Git access (clone upstream LLM Compressor examples).  
* Optional: Multi-GPU setup; sample calibration dataset (e.g., from Hugging Face datasets).  
* Basic Python, Podman, and LLM concepts (quantization, calibration).

**Duration:** 90–120 minutes, including hands-on labs (setup \+ basic quantization 50–70 min; advanced recipes \+ serving 40–50 min).

**Format:** Slides/overview → Live Podman demos → Guided hands-on container exercises → Q\&A/troubleshooting.

**Key Outcomes:** Participants should leave able to:

* Install/run the Model Optimization Toolkit container and apply compression recipes.  
* Quantize models with popular schemes (INT8/INT4/FP8/NVFP4) and transforms.  
* Generate and validate compressed-tensors outputs for vLLM serving.  
* Benchmark compression benefits (size reduction, inference speedup) and integrate with inference server deployments.

### Topic 1: Overview of Red Hat AI Model Optimization Toolkit {#topic-1:-overview-of-red-hat-ai-model-optimization-toolkit}

**Goal:** Understand the toolkit, its basis on LLM Compressor, and compression trade-offs.

**Core Concepts to Cover:**

* Toolkit: Developer Preview container (rhaiis/model-opt-cuda-rhel9:3.2.x) packaging LLM Compressor for quantization/sparsity/transforms.  
* Benefits: Reduce VRAM (e.g., FP16 → INT4/FP8 cuts \~50–75%), lower latency, enable larger models/batching on same hardware.  
* Methods: Quantization (weight-only/activation-aware), sparsity (structured zeroing), transforms (additional ops for accuracy recovery).  
* Formats: Outputs compressed-tensors (Safetensors extension) → native vLLM support.  
* Supported: Hugging Face models (LLMs, multimodal, MoE like DeepSeek/Mixtral).  
* Hands-on intro: Pull container → verify version (python \-c "import llmcompressor; print(llmcompressor.\_\_version\_\_)").

### Topic 2: Setting Up the Environment and Pulling the Container {#topic-2:-setting-up-the-environment-and-pulling-the-container}

**Goal:** Prepare GPU host and run the toolkit container.

**Core Concepts to Cover:**

* Prerequisites: Podman, GPU access, HF token, SELinux tweak.  
* Pull: podman pull registry.redhat.io/rhaiis/model-opt-cuda-rhel9:3.2.x.  
* Working dir: Clone LLM Compressor repo (git clone https://github.com/vllm-project/llm-compressor.git && cd llm-compressor && git checkout 0.8.1).  
* Env: Source .env with HF\_TOKEN.  
* Mount: \-v $(pwd):/opt/app-root/model-opt for examples.  
* Hands-on: Pull image → clone repo → set token → test basic run (podman run \--rm \-it \<image\> python \-c "import llmcompressor").

### Topic 3: Applying Basic Quantization Recipes {#topic-3:-applying-basic-quantization-recipes}

**Goal:** Run example compression workflows.

**Core Concepts to Cover:**

* Recipes: Python scripts (e.g., examples/quantization\_w8a8\_int8/llama3\_example.py for w8a8 INT8).  
* Key steps: Load model (Hugging Face), apply compressor (quantization scheme), calibrate (dataset), compress, save (compressed-tensors).  
* Calibration: Required for post-training quantization (e.g., small dataset for scales/zero-points).  
* Hands-on exercise: Run Llama-3 example (podman run ... python .../llama3\_example.py) → monitor logs (compression progress) → verify output directory size reduction.

### Topic 4: Advanced Compression – Multi-Method, Sparsity, Transforms, and MoE {#topic-4:-advanced-compression-–-multi-method,-sparsity,-transforms,-and-moe}

**Goal:** Explore non-uniform and specialized techniques.

**Core Concepts to Cover:**

* Multi-compressor: Stack schemes (e.g., NVFP4 \+ FP8 for MoE).  
* Sparsity: SparseGPT (optional skip via skip\_sparsity\_compression\_stats=True).  
* Transforms: Inject ops (SmoothQuant, QuIP, SpinQuant) for accuracy recovery.  
* MoE/Multimodal: Supported (DeepSeekV3 block FP8, vision-language/audio models).  
* Args/Options: Custom calibration data, recipe overrides.  
* Hands-on: Modify example script for FP8 or multi-scheme → run → compare accuracy/memory vs. baseline.

### Topic 5: Integrating Optimized Models with Inference Server {#topic-5:-integrating-optimized-models-with-inference-server}

**Goal:** Serve compressed models for performance gains.

**Core Concepts to Cover:**

* Save format: compressed-tensors → load directly in vLLM (--model \<path-to-compressed\>).  
* Local Podman: Restart inference server with compressed model path.  
* OCP Deployment: Update args to point to compressed model/PVC.  
* Validation: Benchmark inference (tokens/sec, latency, GPU util) before/after compression.  
* Hands-on: Serve quantized model → run same prompt as baseline → compare metrics.

### Topic 6: Troubleshooting, Limitations, and Best Practices {#topic-6:-troubleshooting,-limitations,-and-best-practices}

**Goal:** Avoid pitfalls and optimize workflows.

**Core Concepts to Cover:**

* Issues: Model access (gated approval), calibration failures (insufficient data), GPU OOM (reduce batch), unsupported schemes (check logs).  
* Limitations: Developer Preview (not production SLA), CUDA-only in container, requires calibration (no data-free for best results).  
* Best practices: Start with small models/calibration sets, use multi-GPU for large compression, scan outputs with security tools, combine with vLLM args (e.g., \--quantization awq).  
* Hands-on (optional): Intentionally skip calibration → observe warning → add dataset → re-run.

