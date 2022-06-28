# Cloud Observability with Grafana and Spring Boot

A Kubernetes observability demo based on
minikube. It demonstrates how to monitor a Spring Boot app using
traces (Tempo), metrics (Prometheus) and logs (Loki) all in Grafana.

[Check out this blog post for more details](https://blog.qaware.de/posts/cloud-observability-grafana-spring-boot/)

## Prerequisites

Please make sure the following tools are available as commands:

* bash
* [docker](https://docs.docker.com/get-docker/)
* [minikube](https://minikube.sigs.k8s.io/docs/start/)
* [helm](https://helm.sh/docs/intro/install/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [k9s](https://github.com/derailed/k9s) (optional)

## Usage

Executing

```
./run-demo.sh
```

will start a minikube cluster, deploy [Grafana,
Prometheus](helm/kube-prometheus-stack), [Tempo](helm/tempo),
[Loki](helm/loki), [Promtail](helm/promtail) and a
[Spring Boot Demo App](spring-boot-app) using helm.

It binds a port-forward to Grafana at http://localhost:3000. Open the "Spring Boot Demo" dashboard in there.

Later on, you can clean up the demo with 
```
minikube delete --profile observability-demo
```

## Links & References

* https://github.com/grafana/tns
* https://github.com/micrometer-metrics/micrometer
* https://linuxczar.net/blog/2022/01/17/java-spring-boot-prometheus-exemplars/
* https://github.com/open-telemetry/opentelemetry-java-instrumentation


* https://grafana.com/blog/2022/05/10/how-to-collect-prometheus-metrics-with-the-opentelemetry-collector-and-grafana/
* https://sysdig.com/blog/prometheus-remote-write-opentelemetry/
* https://opentelemetry.io/docs/reference/specification/metrics/sdk_exporters/prometheus/#:~:text=A%20Prometheus%20Exporter%20is%20a,MUST%20NOT%20support%20Push%20mode.
* https://opentelemetry.uptrace.dev/guide/opentelemetry-prometheus.html#sending-go-metrics-to-prometheus
* https://grafana.com/blog/2022/04/26/set-up-and-observe-a-spring-boot-application-with-grafana-cloud-prometheus-and-opentelemetry/
* https://github.com/adamquan/hello-observability/blob/main/hello-observability/load-generator.sh
* https://aws.amazon.com/blogs/opensource/building-a-helm-chart-for-deploying-the-opentelemetry-operator/
* https://medium.com/swlh/yacr-yet-another-ckad-resource-46c654de871
* https://blog.qaware.de/posts/cloud-observability-grafana-spring-boot/


MUST NEXT STEPS:
* https://www.baeldung.com/micrometer
* https://spring.io/blog/2022/05/19/spring-boot-3-0-0-m3-available-now
* https://micrometer.io/docs/tracing
* https://frontbackend.com/maven/artifact/org.apache.camel/camel-micrometer/3.0.0-M3
* https://grafana.com/blog/2022/05/04/how-to-capture-spring-boot-metrics-with-the-opentelemetry-java-instrumentation-agent/



# Creating the docker image
pack build franroa/otelworkingexample:latest  -e BP_JVM_VERSION=17

# Auto-instrument
We are using a resource from the otel operator called "instrumentation" (https://github.com/open-telemetry/opentelemetry-operator#opentelemetry-auto-instrumentation-injection)
This will add a volume to the pod and inject into the container the opentelemetry java agent.
If you don't want to use the instrumentation resource, you can inject the agent manually: https://grafana.com/blog/2021/02/03/auto-instrumenting-a-java-spring-boot-application-for-traces-and-logs-using-opentelemetry-and-grafana-tempo/

# Collector
The auto-instrumentation will send signals with the OTLP protocol (opentelemetry protocol), this signals will be collected by the collector
and then send to the Grafana platform in a way that Grafana can understand them



Latency
histogram_quantile(0.90, sum(rate(http_server_requests_seconds_bucket[5m])) by (le, verb))


Errors
sum(rate(http_server_requests_seconds_count{job="spring-boot-demo-app1", status=~"5.."}[5m]))   

Error Budget
1 - ((1 - (sum(increase(http_server_requests_seconds_count{job="spring-boot-demo-app1", status=~"2.."}[7d])) by (verb)) /  sum(increase(http_server_requests_seconds_count{job="spring-boot-demo-app1"}[7d])) by (verb)) / (1 - .80))



Availability
sum(rate(http_server_requests_seconds_count{status=~"2.."}[5m])) / sum(rate(http_server_requests_seconds_count[5m]))


Throughput
sum(rate(http_server_requests_seconds_count{status=~"2.."}[5m]))