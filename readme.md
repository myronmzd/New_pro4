**Poject to use kafak**

This is a simple project to demonstrate the use of Apache Kafka for messaging between producers and consumers.

**Poject arch**
```text
┌────────────────────────────────────────────────────────────┐
│                        APPLICATION                          │
│         (AWS Fargate / ECS Tasks / Lambda Functions)        │
│   • App generates logs (stdout / JSON)                      │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                FLUENT BIT / FIRELENS LOG AGENT             │
│   • Automatically collects container logs                   │
│   • Sends to CloudWatch Logs (no custom code)               │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                      CLOUDWATCH LOGS                        │
│   • Central log storage                                     │
│   • Log groups per service                                  │
│   • Retention settings                                      │
└──────────────────────────────┬──────────────────────────────┘
                         Subscription Filter
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                     LOG PROCESSOR (LAMBDA)                  │
│   • Cleans incoming logs                                    │
│   • Adds metadata (service, env, host)                      │
│   • Converts to structured JSON                             │
│   • Sends to OpenSearch index: "app-logs"                   │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                    AMAZON OPENSEARCH (ELK)                  │
│   • Real-time search                                        │
│   • Dashboards (Kibana)                                     │
│   • Error dashboards                                        │
│   • Slow request analysis                                   │
│   • Pattern detection / anomaly detection                   │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                       DEV OBSERVABILITY                     │
│                      (KIBANA DASHBOARD)                     │
│   • Real-time monitoring                                    │
│   • Alerts: Slack / Email / PagerDuty                       │
│   • Log search + filtering                                  │
└──────────────────────────────────────────────────────────────┘



──────────────────────────────────────────────────────────────
                 HISTORICAL ANALYTICS PIPELINE
──────────────────────────────────────────────────────────────

                               │
                    CloudWatch Log Export
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                           S3 DATA LAKE                      │
│   • /logs/raw/                                               │
│   • /logs/structured/                                        │
│   • Long-term storage                                        │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                      AWS ATHENA (SQL)                       │
│   • Query years of logs                                     │
│   • Error trends                                             │
│   • Performance analysis                                     │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌────────────────────────────────────────────────────────────┐
│                      AWS QUICKSIGHT                         │
│   • Weekly/Monthly monitoring dashboards                    │
│   • SLA reports                                             │
│   • Latency heatmaps                                        │
└────────────────────────────────────────────────────────────┘
```


**Final AWS Infrastructure List (Simple & Cheap)** 

| Component    | AWS Resource	    | Size Purpose |
|----------------------------|---------------------------------------------|------------------------|


