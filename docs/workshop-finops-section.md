# Section: FinOps for AI on OpenShift

## Overview

This section demonstrates how OpenShift AI provides cost visibility, usage attribution, and chargeback capabilities for AI model serving. You'll explore how to:

- Track model usage across teams through a single MaaS gateway
- Calculate and compare costs between self-hosted and external models
- Use Perses dashboards for real-time cost monitoring
- Make data-driven decisions about model deployment strategy

## Prerequisites

- OpenShift AI 3.4 with MaaS enabled
- At least 2 GPU-served models (gpt-oss-20b, nemotron-14b) running via KServe
- An external model registered in MaaS (e.g., OpenAI GPT-4o)
- Cluster Observability Operator installed with Perses
- FinOps recording rules and dashboards deployed (`./deploy-finops.sh`)

## Exercise 1: Explore the Model Gateway (10 min)

### Objective
Understand how MaaS serves as a single gateway for all models — self-hosted and external.

### Steps

1. **Log into the RHOAI Dashboard**
   - Navigate to the OpenShift Console
   - Click **Applications** → **Red Hat OpenShift AI**
   - Go to **Model Serving** → **Models as a Service**

2. **Browse the Model Catalog**
   You should see three models:
   - **gpt-oss-20b** — self-hosted on GPU (KServe + vLLM)
   - **nemotron-14b** — self-hosted on GPU (KServe + vLLM)
   - **gpt-4o** — external model (OpenAI API)

3. **Create a Subscription**
   - Click on any model
   - Click **Subscribe**
   - Note the token limits and rate limits configured
   - Copy your API key

4. **Test the Endpoint**
   ```bash
   MAAS_URL="https://inference.maas.<cluster-domain>"
   API_KEY="<your-api-key>"

   # Test self-hosted model
   curl -s "$MAAS_URL/v1/chat/completions" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $API_KEY" \
     -d '{
       "model": "gpt-oss-20b",
       "messages": [{"role": "user", "content": "What is FinOps?"}],
       "max_tokens": 100
     }' | jq .

   # Test external model (same endpoint!)
   curl -s "$MAAS_URL/v1/chat/completions" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $API_KEY" \
     -d '{
       "model": "gpt-4o",
       "messages": [{"role": "user", "content": "What is FinOps?"}],
       "max_tokens": 100
     }' | jq .
   ```

### Key Takeaway
All models — self-hosted and external — are accessed through the same endpoint with the same API format. This is the foundation for unified cost tracking.

## Exercise 2: Generate Load (5 min)

### Objective
Create realistic usage patterns to populate the dashboards.

### Steps

1. **Run the load generator**
   ```bash
   ./scripts/finops-load-generator.sh "https://inference.maas.<cluster-domain>" 15 "<api-key>"
   ```

2. **Observe the output** — the script simulates three teams:
   - **Team Alpha**: Data science — heavy gpt-oss-20b usage
   - **Team Bravo**: Engineering — heavy nemotron-14b usage
   - **Team Charlie**: Product — mixed usage

3. **Let it run** for at least 10 minutes while you proceed to the next exercise.

## Exercise 3: Cost Visibility (15 min)

### Objective
Use the Perses dashboards to understand where money is being spent on AI inference.

### Steps

1. **Open Perses**
   - In the OpenShift Console, navigate to **Observe** → **Dashboards**
   - Or access Perses directly at the route URL

2. **Cost Overview Dashboard**
   - Open the **FinOps Cost Overview** dashboard
   - **Total Hourly Spend**: How much are we spending per hour on self-hosted models?
   - **Cost by Model**: Which model costs more to run?
   - **Cost per 1K Tokens**: Which model is more cost-efficient per token?

   > **Discussion**: The cost per GPU-hour is fixed ($1.40 for g6e.4xlarge), but the cost per token depends on utilization. A busy model is cheaper per token than an idle one.

3. **Chargeback Dashboard**
   - Open the **FinOps Chargeback** dashboard
   - **Tokens by Model**: Which model is handling more traffic?
   - **Request Volume**: How many requests per second is each model serving?
   - **Token Usage Breakdown**: How does usage distribute across models over time?

4. **Model Efficiency Dashboard**
   - Open the **Model Efficiency** dashboard
   - **GPU Utilization**: Are we fully utilizing the GPUs we're paying for?
   - **Tokens per Dollar**: Which model gives us the most value per dollar?
   - **KV Cache**: Is the cache being used effectively?

5. **Executive Summary**
   - Open the **FinOps Executive Summary** dashboard
   - **Monthly Projected Cost**: What would this usage pattern cost at scale?
   - **Self-Hosted Savings**: How much are we saving vs. sending everything to OpenAI?

### Key Takeaway
The same metrics pipeline that monitors model health also provides cost attribution — no separate billing system needed.

## Exercise 4: Optimization Decisions (10 min)

### Objective
Use the data to make cost-optimization decisions.

### Steps

1. **Calculate Self-Hosted ROI**
   From the dashboards, gather:
   - Total tokens served per hour (self-hosted): ___
   - GPU cost per hour: $1.40 per model
   - Equivalent external API cost: tokens × $0.01/1K tokens = $___

   **ROI**: If external cost > GPU cost, self-hosting saves money.

2. **Identify Optimization Opportunities**
   - If GPU utilization < 50%, the GPU is underutilized. Options:
     - Route more traffic to the self-hosted model (improve economics)
     - Scale down to smaller instance during low-traffic periods
     - Consolidate models onto fewer GPUs
   - If KV cache utilization is low, prefix caching isn't being used effectively

3. **Set Cost Controls in MaaS**
   - In the RHOAI Dashboard, edit a subscription
   - Set token limits (e.g., 100K tokens per hour)
   - This prevents runaway costs from a single consumer

4. **Model Selection Strategy**
   | Scenario | Recommendation |
   |----------|----------------|
   | High volume, latency tolerant | Self-hosted (lower cost per token at scale) |
   | Low volume, bursty | External API (no idle GPU cost) |
   | Sensitive data | Self-hosted (data stays on-cluster) |
   | Maximum quality needed | External API (GPT-4o) |

### Key Takeaway
FinOps for AI isn't just about tracking costs — it's about making informed decisions on where to run inference based on data.

## Summary

In this section, you learned how OpenShift AI provides:

1. **Unified Access**: Single MaaS gateway for all models (self-hosted + external)
2. **Cost Visibility**: Real-time dashboards showing per-model, per-team costs
3. **Cost Attribution**: Token-level usage tracking for chargeback
4. **Optimization Data**: GPU utilization and efficiency metrics to guide decisions

The FinOps principle is simple: **visibility enables accountability, accountability enables optimization.**

## Cost Model Reference

| Resource | Cost | Notes |
|----------|------|-------|
| g6e.4xlarge (1x L40S) | $1.40/hr | Self-hosted model serving |
| OpenAI GPT-4o Input | $2.50/1M tokens | External API |
| OpenAI GPT-4o Output | $10.00/1M tokens | External API |
| Self-hosted per-token | Dynamic | $1.40/hr ÷ tokens served |

The break-even point: if a self-hosted model serves more than ~140K tokens/hr, it's cheaper per token than GPT-4o output pricing.
