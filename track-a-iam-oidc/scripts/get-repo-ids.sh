#!/usr/bin/env bash
# Imprime los IDs numéricos del dueño y del repositorio (API pública de GitHub) y el valor de `sub`
# que emitirá GitHub Actions para tu rama. Uso: ./get-repo-ids.sh OWNER REPO [RAMA]
set -euo pipefail

OWNER="${1:?Uso: $0 OWNER REPO [RAMA]}"
REPO="${2:?Uso: $0 OWNER REPO [RAMA]}"
BRANCH="${3:-main}"

json="$(curl -fsS "https://api.github.com/repos/${OWNER}/${REPO}")" || {
  echo "No pude leer https://api.github.com/repos/${OWNER}/${REPO}. ¿El repositorio es público y el nombre es exacto?" >&2
  exit 1
}

PY="$(command -v python3 || command -v python || true)"
[ -n "$PY" ] || { echo "Necesito python3 (o python) para leer el JSON." >&2; exit 1; }

read -r OWNER_ID REPO_ID REAL_OWNER REAL_REPO < <(
  printf '%s' "$json" | "$PY" -c '
import json, sys
d = json.load(sys.stdin)
print(d["owner"]["id"], d["id"], d["owner"]["login"], d["name"])
'
)

cat <<EOF
Dueño:        ${REAL_OWNER}  (id ${OWNER_ID})
Repositorio:  ${REAL_REPO}  (id ${REPO_ID})
Rama:         ${BRANCH}

sub esperado (formato inmutable, repos creados o renombrados desde el 15-jul-2026):
  repo:${REAL_OWNER}@${OWNER_ID}/${REAL_REPO}@${REPO_ID}:ref:refs/heads/${BRANCH}

sub en formato antiguo (solo para el ejercicio A3):
  repo:${REAL_OWNER}/${REAL_REPO}:ref:refs/heads/${BRANCH}

Despliegue:
  aws cloudformation deploy \\
    --stack-name trust-chain-lab-a \\
    --template-file track-a-iam-oidc/cfn/github-oidc-role.yaml \\
    --capabilities CAPABILITY_NAMED_IAM \\
    --region us-east-1 \\
    --parameter-overrides \\
      GitHubOwner=${REAL_OWNER} GitHubOwnerId=${OWNER_ID} \\
      GitHubRepo=${REAL_REPO} GitHubRepoId=${REPO_ID} Branch=${BRANCH}
EOF
