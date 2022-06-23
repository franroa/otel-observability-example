#!/usr/bin/env bash
set -euo pipefail

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


helm_install spring-boot default spring-boot-demo-app1
kubectl apply -f app-golang/manifests