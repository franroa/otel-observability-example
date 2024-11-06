# kubectl create ns otel-tempo
# this is not working: you need for cert-manager to be deployed before applying opentelemetry operator
# kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
kubectl apply -n opentelemetry-operator-system -f tempocollector.yaml,tempoinstrumentation.yaml
