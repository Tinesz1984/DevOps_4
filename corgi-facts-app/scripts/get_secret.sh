#!/bin/bash

export VAULT_ADDR='http://host.docker.internal:8200'
export VAULT_TOKEN='root'

SECRET=$(curl \
  --silent \
  --header "X-Vault-Token: $VAULT_TOKEN" \
  $VAULT_ADDR/v1/kv/data/corgi | jq -r '.data.data.fun_fact')

export SECRET

echo "Secret received successfully"