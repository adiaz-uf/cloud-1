#!/bin/bash
# Script to view secrets (temporarily decrypted)

VAULT_FILE="ansible/group_vars/targets/vault.yml"
VAULT_PASS_FILE=".vault_pass"

echo "Ansible Vault - View secrets"
echo "================================="
echo ""

if [ ! -f "$VAULT_FILE" ]; then
    echo "Error: $VAULT_FILE not found"
    exit 1
fi

if [ -f "$VAULT_PASS_FILE" ]; then
    ansible-vault view "$VAULT_FILE" --vault-password-file="$VAULT_PASS_FILE"
else
    echo "Enter vault password:"
    ansible-vault view "$VAULT_FILE"
fi
