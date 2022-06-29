show code
show pack

Find an error in Demo App and jump to the logs, also jump to the trace
find a trace - 4e9837acc7818262

LogQL
explain that works with labels (same service discovery as Prometheus. You should use the same labels for both)
search autocompletion
kubernetes events - {job="eventrouter/eventrouter"}         {app="eventrouter"}
json vs logfmt - SHOW THE CONTAINER LOGS: {job="apps/test-logger-logfmt"} - show the level=info
structured data - Promtail (json loki parser)
distributed grep
AD-HOC metrics: sum(rate(({job="default/loadgen"})[1m]))
- cuando no hay instrumentation
- cuando no quieres guarda muchas metricas en base de datos que usas poco frecuentemente
  Loki alerts


labels:
- stick to topology
- not dynamic labels
- more is less!
- too many labels index gets too big
- too few, the data cant be sharded over enough ingesters
- labels are also important for writes and queries (paralellism)
https://grafana.com/docs/loki/latest/logql/
EKS Configuration
NOTE: you jump to the span logs, not to the trace logs



TraceQL
Loki Search - Loki indexes shared with tempo - {job="default/app"}  |= "error"
- {job="default/app"}  |= "error"
- {job="default/app"}  |= "error" != "timeout"
- {job="default/app"}  |~ `(?i)error`
- {job="default/app"}  |= ip(1.2.3.4)
ONGOING:
- pipelines of spansets
- aggregates
- parquet
Teampo Search
git integration
query builder
metrics generator
- span metrics - RED - trace to metrics
- service graph metrics


Promtail
Structured Logs
- Stages: mask the password: https://grafana.com/docs/loki/latest/clients/promtail/stages/replace/#without-source
- https://grafana.com/docs/loki/latest/clients/aws/eks/

SLIs
Datalink to deep dive
Data link to FinOps https://grafana.com/grafana/dashboards/139


https://raw.githubusercontent.com/micrometer-metrics/micrometer/main/scripts/spring-dash/jvmgc-dashboard.json
https://raw.githubusercontent.com/micrometer-metrics/micrometer/main/scripts/spring-dash/latency-dashboard.json
https://raw.githubusercontent.com/micrometer-metrics/micrometer/main/scripts/spring-dash/processor-dashboard.json
https://grafana.com/grafana/dashboards/13788
https://grafana.com/grafana/dashboards/5373
https://grafana.com/grafana/dashboards/3662




TO CHECK:
https://grafana.com/go/webinar/logging-with-loki-essential-configuration-settings/?pg=docs-loki&plcmt=footer-resources-2

https://grafana.com/go/webinar/managing-log-privacy-with-loki/?pg=webinar-logging-with-loki-essential-configuration-settings&plcmt=resources-list-3

https://grafana.com/blog/2021/12/29/grafana-loki-2021-year-in-review/?pg=managing-log-privacy-with-loki&plcmt=related-content-3

https://medium.com/empathyco/cloud-finops-part-4-kubernetes-cost-report-b4964be02dc3

https://grafana.com/grafana/dashboards/13446

https://grafana.com/grafana/dashboards/139

https://johanneskonings.dev/aws/2020/11/27/aws_billing_metrics_and_grafana_cloud/

https://grafana.com/orgs/kubecost

https://grafana.com/grafana/dashboards/15714

https://grafana.com/orgs/kubecost

https://grafana.com/grafana/dashboards/11270

https://github.com/dnavarrom/grafana-aws-cost-explorer-backend

https://grafana.com/grafana/dashboards/13514

https://blog.kubecost.com/blog/lens-kubecost-extension/

https://www.taloflow.ai/blog/aws-cloud-cost-management

https://guide.kubecost.com/hc/en-us/articles/4407601807383-Kubernetes-Cost-Allocation


