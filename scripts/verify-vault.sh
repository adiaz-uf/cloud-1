#!/bin/bash
# Script to verify Ansible Vault configuration

echo "Ansible Vault Verification"
echo "=============================="
echo ""

EXIT_CODE=0

# Check if vault.yml exists
if [ -f "ansible/group_vars/targets/vault.yml" ]; then
    echo "vault.yml file found"
else
    echo "ERROR: ansible/group_vars/targets/vault.yml not found"
    EXIT_CODE=1
fi

# Check if file is encrypted
if [ -f "ansible/group_vars/targets/vault.yml" ]; then
    if grep -q "ANSIBLE_VAULT" "ansible/group_vars/targets/vault.yml"; then
        echo "vault.yml file is encrypted"
    else
        echo "WARNING: vault.yml is NOT encrypted"
        echo "Run: make setup-vault"
        EXIT_CODE=1
    fi
fi

# Check if vars.yml exists
if [ -f "ansible/group_vars/targets/vars.yml" ]; then
    echo "vars.yml file found"
else
    echo "ERROR: ansible/group_vars/targets/vars.yml not found"
    EXIT_CODE=1
fi

# Check .gitignore
if grep -q ".vault_pass" ".gitignore"; then
    echo ".vault_pass is in .gitignore"
else
    echo "WARNING: .vault_pass is NOT in .gitignore"
    EXIT_CODE=1
fi

# Check if .vault_pass exists
if [ -f ".vault_pass" ]; then
    echo ".vault_pass file found (automatic deployment enabled)"
    echo "Make sure this file is NEVER committed"
else
    echo "ℹ️  .vault_pass file not found (password will be requested on deployment)"
    echo "   To create: echo 'your_password' > .vault_pass"
fi

# Check scripts
echo ""
echo "Available scripts:"
for script in scripts/*.sh; do
    if [ -x "$script" ]; then
        echo "$(basename $script)"
    else
        echo "$(basename $script) - No execute permissions"
        EXIT_CODE=1
    fi
done

echo ""
echo "=============================="
if [ $EXIT_CODE -eq 0 ]; then
    echo "Configuration is correct!"
    echo ""
    echo "Next steps:"
    echo "  1. If vault.yml is not encrypted: make setup-vault"
    echo "  2. Deploy: make ansible-vault"
else
    echo "There are issues with the configuration"
    echo ""
    echo "Run: make setup-vault"
fi

exit $EXIT_CODE
