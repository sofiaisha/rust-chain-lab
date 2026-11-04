#!/usr/bin/env bash
# Imprime los comandos de la pista C con tu ID de cuenta ya resuelto (no ejecuta nada en AWS salvo
# `sts get-caller-identity`). Uso: ./render-cluster.sh
set -euo pipefail

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/trust-chain-lab-ssm-read"

cat <<EOF
Cuenta: ${ACCOUNT_ID}
Política de mínimo privilegio: ${POLICY_ARN}

# C0 · parámetro y política
aws cloudformation deploy --stack-name trust-chain-lab-c --template-file track-c-eks-identity/cfn/ssm-read-policy.yaml \\
  --capabilities CAPABILITY_NAMED_IAM --region us-east-1

# C1 · clúster (tarda varios minutos; empieza el cobro)
eksctl create cluster -f track-c-eks-identity/cluster.yaml

# C2 · IRSA
kubectl create namespace lab
eksctl create iamserviceaccount --cluster trust-chain-lab --region us-east-1 --namespace lab --name irsa-reader \\
  --attach-policy-arn ${POLICY_ARN} --approve

# C3 · EKS Pod Identity
eksctl create podidentityassociation --cluster trust-chain-lab --region us-east-1 --namespace lab \\
  --service-account-name pi-reader --create-service-account --permission-policy-arns ${POLICY_ARN}
EOF
