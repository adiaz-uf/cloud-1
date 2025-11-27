#!/bin/bash
# Script to encrypt secrets with Ansible Vault

VAULT_FILE="ansible/group_vars/targets/vault.yml"
VAULT_PASS_FILE=".vault_pass"

echo "Ansible Vault - Encrypt secrets"
echo "===================================="
echo ""

# Check if file is already encrypted
if grep -q "ANSIBLE_VAULT" "$VAULT_FILE"; then
    echo "File is already encrypted."
    echo ""
    read -p "Do you want to re-encrypt it? (y/n): " response
    if [ "$response" != "y" ]; then
        echo "Operation cancelled."
        exit 0
    fi
    
    # Decrypt first
    if [ -f "$VAULT_PASS_FILE" ]; then
        ansible-vault decrypt "$VAULT_FILE" --vault-password-file="$VAULT_PASS_FILE"
    else
        ansible-vault decrypt "$VAULT_FILE"
    fi
fi

echo ""
echo "Enter a password for the vault (remember it well):"

# Encrypt the file
ansible-vault encrypt "$VAULT_FILE"

if [ $? -eq 0 ]; then
    echo ""
    echo "Secrets encrypted successfully!"
    echo ""
    echo "Next steps:"
    echo "   1. Save the vault password in a secure place"
    echo "   2. To use the playbook: make ansible-vault"
    echo "   3. Or create .vault_pass with your password (DO NOT commit)"
    echo ""
    
    read -p "Do you want to create .vault_pass now? (y/n): " create_file
    if [ "$create_file" = "y" ]; then
        read -sp "Enter vault password: " vault_password
        echo ""
        echo "$vault_password" > "$VAULT_PASS_FILE"
        chmod 600 "$VAULT_PASS_FILE"
        echo "File .vault_pass created (added to .gitignore)"
    fi
else
    echo ""
    echo "Error encrypting file"
    exit 1
fi
