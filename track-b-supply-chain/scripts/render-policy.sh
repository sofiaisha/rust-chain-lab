#!/usr/bin/env bash
# Genera policies/verify-signed-images.yaml a partir de la plantilla.
# Uso: ./render-policy.sh OWNER REPO
# Usa el dueño y el repositorio EXACTOS de tu fork, en minúsculas para la ruta de la imagen en GHCR.
set -euo pipefail

OWNER="${1:?Uso: $0 OWNER REPO}"
REPO="${2:?Uso: $0 OWNER REPO}"
HERE="$(cd "$(dirname "$0")/.." && pwd)"

OWNER_LC="$(printf '%s' "$OWNER" | tr '[:upper:]' '[:lower:]')"
REPO_LC="$(printf '%s' "$REPO" | tr '[:upper:]' '[:lower:]')"

# La ruta de la imagen va en minúsculas; la identidad del workflow conserva las mayúsculas del repositorio.
sed -e "s#ghcr.io/__OWNER__/__REPO__/demo#ghcr.io/${OWNER_LC}/${REPO_LC}/demo#" \
    -e "s#__OWNER__#${OWNER}#g" \
    -e "s#__REPO__#${REPO}#g" \
    "$HERE/policies/verify-signed-images.tpl.yaml" > "$HERE/policies/verify-signed-images.yaml"

echo "Escribí $HERE/policies/verify-signed-images.yaml"
echo "Identidad esperada:"
grep -m1 "subject:" "$HERE/policies/verify-signed-images.yaml"
