#!/usr/bin/env bash
# Borra el clúster local de la pista B.
set -euo pipefail
kind delete cluster --name trust-chain
