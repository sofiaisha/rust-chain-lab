#!/usr/bin/env bash
# Limpieza de la pista C. Ejecútala siempre al terminar: el clúster cobra por hora.
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"

kubectl delete namespace lab --ignore-not-found || true
eksctl delete cluster -f "$HERE/cluster.yaml" --wait --disable-nodegroup-eviction
aws cloudformation delete-stack --stack-name trust-chain-lab-c --region us-east-1
aws cloudformation wait stack-delete-complete --stack-name trust-chain-lab-c --region us-east-1

echo "Revisa en CloudFormation que no queden pilas eksctl-trust-chain-lab-* (roles de IRSA o Pod Identity)."
