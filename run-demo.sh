#!/usr/bin/env bash
set -euo pipefail

#export MINIKUBE_IN_STYLE=false
#MINIKUBE_PROFILE=observability-demo
#echo ">>>> Starting minikube with profile $MINIKUBE_PROFILE..."
#
#minikube start --profile $MINIKUBE_PROFILE
#minikube profile $MINIKUBE_PROFILE
#
#echo ">>>> Building & pushing Spring Boot Demo App..."
## sleep a bit as minikube's network might not be present immediately,
## failing the build with curl
#sleep 15
#
#eval "$(minikube -p $MINIKUBE_PROFILE docker-env)"
#(cd spring-boot-app; docker build -q -t "spring-boot-app:latest" .)




kind create cluster

helm_install() {
  local chart_name=$1
  local namespace=$chart_name
  if [[ -n "${2:-}" ]]; then
      namespace=$2
  fi
  local release_name=$chart_name
  if [[ -n "${3:-}" ]]; then
      release_name=$3
  fi
  echo ">>>> Installing helm chart $chart_name into namespace $namespace as release $release_name"
  kubectl create namespace "$namespace" --dry-run=client -o yaml | kubectl apply -f -
  (cd "helm/$chart_name"; \
    helm dependency update >/dev/null \
    && helm upgrade --namespace "$namespace" --install "$release_name" .)
}

setup_monitoring() {
  local dashboard_path
  for dashboard_path in dashboards/*.json; do
      local name
      name=$(basename "$dashboard_path")
      name="dashboard-${name%.*}"
      kubectl create configmap "$name" --namespace kube-prometheus-stack --from-file="$dashboard_path" \
          --dry-run=client --output=yaml --save-config | kubectl apply --filename=-
      kubectl label configmap "$name" --namespace=kube-prometheus-stack grafana_dashboard=1 --overwrite
  done
}

setup_test_loggers() {

    helm upgrade test-logger-json helm/test-logger --install --wait \
        --namespace=apps --create-namespace \
        --values=config/test-logger/values-json.yaml

    helm upgrade test-logger-logfmt helm/test-logger --install --wait \
        --namespace=apps --create-namespace \
        --values=config/test-logger/values-logfmt.yaml

}

helm_install kube-prometheus-stack
setup_monitoring

helm_install tempo
helm_install promtail
helm_install loki
helm_install eventrouter

#helm upgrade -i --create-namespace kubecost kubecost/cost-analyzer --namespace kubecost --set kubecostToken="aGVsbUBrdWJlY29zdC5jb20=xm343yadf98"
helm upgrade --install kubecost kubecost/cost-analyzer \
    --namespace kubecost \
    --set serviceMonitor.enabled=true \
    --set global.prometheus.fqdn=kube-prometheus-stack-prometheus.kube-prometheus-stack \
    --set global.prometheus.enabled=false
#k port-forward svc/kubecost-cost-analyzer 9003
#http://localhost:9003/metrics

setup_test_loggers

echo ">>>> Waiting max 5min for deployments to finish...(you may watch progress using k9s)"
kubectl wait --for=condition=ready --timeout=5m pod -n kube-prometheus-stack -l app.kubernetes.io/name=grafana
# setup port forward for grafana
echo ">>>> Setting up port-forward (end with Ctrl-C), you can login to Grafana now at http://localhost:3000"
kubectl port-forward -n kube-prometheus-stack deployment/kube-prometheus-stack-grafana 3000:3000