#!/bin/bash
# Generate sealed secrets from plaintext (store plaintext in .gitignore!)

SECRET_NAME=$1
NAMESPACE=${2:-infrastructure}

kubectl create secret generic $SECRET_NAME \
  --from-literal=password=$(openssl rand -base64 32) \
  --dry-run=client -o yaml | \
  kubeseal --format yaml > infrastructure/base/secrets/${SECRET_NAME}-sealed.yaml

echo " SealedSecret created: ${SECRET_NAME}-sealed.yaml"