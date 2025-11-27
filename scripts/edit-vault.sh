#!/bin/bash
# Script to edit encrypted secrets

VAULT_FILE="ansible/group_vars/targets/vault.yml"
VAULT_PASS_FILE=".vault_pass"

echo "Ansible Vault - Edit secrets"
echo "================================="
echo ""

if [ ! -f "$VAULT_FILE" ]; then
    echo "Error: $VAULT_FILE not found"
    exit 1
fi

if [ -f "$VAULT_PASS_FILE" ]; then
    ansible-vault edit "$VAULT_FILE" --vault-password-file="$VAULT_PASS_FILE"
else
    echo "Enter vault password:"
    ansible-vault edit "$VAULT_FILE"
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "Secrets updated successfully!"
else
    echo ""
    echo "Error editing file"
    exit 1
fi
