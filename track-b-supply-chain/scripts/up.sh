#!/usr/bin/env bash
# Crea el clúster kind e instala Kyverno 1.19.2 (chart 3.9.2).
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"

kind create cluster --name trust-chain --config "$HERE/kind-config.yaml"

helm repo add kyverno https://kyverno.github.io/kyverno/helm
helm repo update
helm install kyverno kyverno/kyverno --version 3.9.2 -n kyverno --create-namespace --wait --timeout 5m

kubectl get pods -n kyverno
