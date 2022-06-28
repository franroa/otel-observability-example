Find an error in Demo App and jump to the logs

find a log
find a trace


show code
show pack


TraceQL
- pipelines of spansets
- aggregates
- parquet
Loki Search - Loki indexes shared with tempo - {job="default/app"}  |= "error"
- {job="default/app"}  |= "error"
- {job="default/app"}  |= "error" != "timeout"
- {job="default/app"}  |~ `(?i)error`
- {job="default/app"}  |= ip(1.2.3.4)
Teampo Search
git integration
query builder
metrics generator
- span metrics - RED - trace to metrics
- service graph metrics

LogQL
explain that works with labels
search autocompletion
kubernetes events
json vs logfmt
labels:
- stick to topology
- not dynamic labels
- more is less!
- too many labels index gets too big
- too few, the data cant be sharded over enough ingesters
- labels are also important for writes and queries (paralellism)
- structured data
- no schema
json loki parser 
distributed grep
Loki alerts
ad-hoc metrics: sum(rate(({job="default/loadgen"})[1m]))
- cuando no hay instrumentation
- cuando no quieres guarda muchas metricas en base de datos que usas poco frecuentemente
  https://grafana.com/docs/loki/latest/logql/
EKS Configuration
NOTE: you jump to the span logs, not to the trace logs


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


