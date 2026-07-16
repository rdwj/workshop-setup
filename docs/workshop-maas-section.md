# Using Models as a Service

**Objective:** Deploy a model, publish it via MaaS, create a subscription, generate an API key, and test the model endpoint.

In this section, you will learn how to deploy a large language model from the AI Hub, publish it as a managed service, control access through subscriptions, and interact with the model via API.

## Prerequisites

- Access to the RHOAI cluster dashboard
- Workshop credentials: `admin1` / `wfcatalog`
- The cluster has been pre-configured with MaaS components

## Step 1: Log in to the RHOAI Dashboard

1. Navigate to the RHOAI dashboard URL for your cluster:
   ```
   https://rh-ai.apps.<cluster-domain>
   ```
   (Your instructor will provide the exact `<cluster-domain>` for your cluster)

2. Log in with these credentials:
   - Username: `admin1`
   - Password: `wfcatalog`

3. After successful login, verify you can see the following sections in the left navigation:
   - **Gen AI Studio** — for API keys, endpoints, and playground
   - **AI Hub** — for model catalog and MCP servers
   - **Settings** — for subscriptions and tenant configuration

## Step 2: Deploy a Model from AI Hub

1. In the left navigation, click **AI Hub** → **Models**

2. Browse the model catalog and locate a Granite model. For this workshop, we recommend:
   - **granite-8b-code-instruct** — optimized for code generation tasks

3. Click the model card to view details, then click **Deploy**

4. Configure the deployment:
   - **Model server name**: Use the auto-generated name or create a descriptive one
   - **Hardware profile**: Select **NVIDIA GPU** (required for model inference)
   - Expand **Advanced settings**
   - Check the box **Publish as MaaS**
   - **Data Science Project**: Select an existing project (e.g., `granite-model`) or create a new one

5. Click **Deploy**

6. Wait for the model to reach **Ready** status:
   - Initial status: **Pending** — downloading model files
   - Expected wait time: 5-10 minutes (depends on model size and network)
   - Final status: **Ready** — model is serving and ready for requests

You can monitor the deployment progress from the Data Science Projects page.

## Step 3: Verify the Model in Gen AI Studio

1. Navigate to **Gen AI Studio** → **AI asset endpoints**

2. At the top of the page, select the Data Science Project where you deployed the model

3. Verify your model appears in the list with:
   - Status: **Ready**
   - A **View** link to see endpoint details

4. Click **View** to see the inference endpoint URL. Note the structure:
   ```
   https://inference.maas.apps.<cluster-domain>/<project>/<model>/v1/chat/completions
   ```

## Step 4: Create a MaaS Subscription

Subscriptions control which user groups can access which models and enforce token usage limits.

1. Navigate to **Settings** → **Subscriptions**

2. Click **Create subscription**

3. Configure the subscription:
   - **Name**: `workshop-default`
   - **Group**: `workshop-users` (this group was pre-created by the workshop setup)
   - **Priority**: `0` (higher values = higher priority when multiple subscriptions apply)

4. In the **Models** section, click **Add model**:
   - Select your deployed model (e.g., `granite-8b-code-instruct`)
   - Set **Token limit**: `100000` tokens per `1h` (one hour)
   - This prevents any single user from consuming excessive resources

5. Check the box **Create a matching authorization policy**
   - This automatically creates an API gateway policy to enforce subscription access

6. Click **Create**

The subscription is now active. Any user in the `workshop-users` group can generate API keys scoped to this subscription.

## Step 5: Generate an API Key

API keys authenticate requests to MaaS-published models.

1. Navigate to **Gen AI Studio** → **API keys**

2. Click **Create API key**

3. Configure the API key:
   - **Name**: Give it a descriptive name (e.g., `my-workshop-key`)
   - **Subscription**: Select `workshop-default`
   - **Expiration**: Keep the default (30 days)

4. Click **Create**

5. **IMPORTANT**: Copy the API key immediately
   - The key is displayed only once for security reasons
   - The key starts with `sk-oai-`
   - Store it securely (e.g., in a password manager or secure notes)

If you lose the key, you cannot recover it. You must create a new API key.

## Step 6: Test the Model via API

Now that you have a deployed model, an active subscription, and an API key, you can test the inference endpoint.

### Using curl

Replace the placeholders in the command below:
- `<cluster-domain>` — your cluster's domain
- `<project>` — your Data Science Project name
- `<model>` — your model name
- `<your-api-key>` — the API key you generated

```bash
curl -sk https://inference.maas.apps.<cluster-domain>/<project>/<model>/v1/chat/completions \
  -H "Authorization: Bearer sk-oai-<your-api-key>" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "granite-8b-code-instruct",
    "messages": [{"role": "user", "content": "Write a Python function to reverse a string"}],
    "max_tokens": 200
  }'
```

### Expected Response

You should receive a JSON response containing the model's completion:

```json
{
  "id": "chatcmpl-...",
  "object": "chat.completion",
  "created": 1234567890,
  "model": "granite-8b-code-instruct",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "def reverse_string(s):\n    return s[::-1]"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 12,
    "total_tokens": 27
  }
}
```

### Troubleshooting

- **401 Unauthorized**: Check that your API key is correct and starts with `sk-oai-`
- **403 Forbidden**: Verify the subscription and authorization policy are active
- **404 Not Found**: Verify the endpoint URL matches your project and model name
- **504 Gateway Timeout**: The model may still be initializing. Wait 1-2 minutes and retry.

## Step 7: Use the Playground

The Gen AI Studio includes an interactive playground for testing models without writing code.

1. Navigate to **Gen AI Studio** → **AI asset endpoints**

2. Locate your model in the list and click **Add to playground**

3. In the playground:
   - Type a message in the chat input
   - Press **Send** or press Enter
   - The model's response appears in the conversation thread

4. Experiment with different prompts:
   - Code generation: "Write a Bash script to backup a directory"
   - Code explanation: "Explain what this Python code does: `[1,2,3].map(lambda x: x**2)`"
   - Debugging: "Why does this code fail? `def foo(): return x`"

The playground uses your API key in the background and counts against your subscription's token limits.

## Step 8: View MCP Servers (Optional)

The Model Context Protocol (MCP) enables models to interact with external tools and data sources.

1. Navigate to **Gen AI Studio** → **AI asset endpoints**

2. Click the **MCP servers** tab to see deployed MCP servers in your project

3. To browse the full catalog:
   - Navigate to **AI Hub** → **MCP Servers** → **Catalog**
   - Explore available MCP servers for capabilities like:
     - File system access
     - Database querying
     - Web search
     - Custom business logic

MCP servers can be deployed similarly to models and integrated into agent workflows.

## Understanding MaaS Concepts

### Subscriptions

Subscriptions define which user groups can access which models and enforce resource limits:
- **Group-based access**: Assign subscriptions to OpenShift groups (e.g., `workshop-users`)
- **Model selection**: Add specific models with individual token limits
- **Token limits**: Prevent abuse by capping tokens per time window (e.g., 100k tokens/hour)
- **Priority**: When a user belongs to multiple groups with multiple subscriptions, the highest priority wins

### Authorization Policies

Authorization policies are API gateway rules that enforce subscription access:
- Automatically created when you check **Create a matching authorization policy**
- Control which subscriptions can route requests to which models
- Managed in the Settings → Authorization policies section

### API Keys

API keys authenticate users and are scoped to a subscription:
- Format: `sk-oai-<random-string>`
- Shown only once at creation time for security
- Can be revoked from the API keys page
- Expire automatically based on tenant configuration (default 30 days)
- Each request counts against the subscription's token limits

### Token Limits

Token limits prevent resource exhaustion:
- Configured per model in a subscription
- Format: `<token-count>` tokens per `<time-window>` (e.g., `100000` per `1h`)
- Enforced by the MaaS gateway
- Requests that exceed limits return HTTP 429 (Too Many Requests)

### Tenant

The tenant is the cluster-wide MaaS configuration:
- **API key expiration**: Default time-to-live for new API keys (e.g., 30 days)
- **Telemetry**: Enable/disable usage metrics collection
- **Gateway settings**: Timeout, retry policies, logging
- Managed in Settings → Tenant

## Next Steps

You have successfully:
- Deployed a model from the AI Hub
- Published it as a MaaS endpoint
- Created a subscription to control access
- Generated an API key
- Tested the model via API and playground

In the next section, you will explore advanced topics:
- Integrating models with MCP servers
- Building agentic workflows with LlamaStack
- Monitoring model usage and performance
- Deploying custom models with vLLM
