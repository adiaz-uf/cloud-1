# 🔐 Ansible Vault Guide - Secure Secret Management

## 📋 What is Ansible Vault?

Ansible Vault is a tool that allows you to encrypt sensitive files (passwords, API keys, etc.) so you can securely store them in your Git repository.

## 🚀 Initial Setup

### 1. Encrypt your secrets for the first time

```bash
make setup-vault
```

This command:
- ✅ Will ask for a master password (remember it well)
- ✅ Encrypts the file `ansible/group_vars/targets/vault.yml`
- ✅ Optionally creates `.vault_pass` to avoid password prompts

**⚠️ IMPORTANT**: The vault password is NOT saved in the repository. You should:
- Save it in a password manager (LastPass, 1Password, Bitwarden)
- Share it securely with your team
- Or create `.vault_pass` locally (never commit this file)

### 2. Verify the vault is encrypted

```bash
cat ansible/group_vars/targets/vault.yml
```

You should see something like:
```
$ANSIBLE_VAULT;1.1;AES256
66386439653937336366636236613233376161653935336331...
```

## 🛠️ Available Commands

### Deploy to AWS with vault

```bash
# Option 1: With .vault_pass file (recommended)
make ansible-vault

# Option 2: Entering password manually
make ansible-vault
# You'll be prompted: "Vault password:"
```

### Edit secrets

```bash
make edit-vault
```

This will open the file in your default editor (vim/nano) and allow you to:
- Change passwords
- Add new secrets
- Modify existing values

When saved, it will be automatically re-encrypted.

### View secrets (without editing)

```bash
make view-vault
```

Shows decrypted content in terminal without opening an editor.

## 📁 File Structure

```
ansible/
├── group_vars/
│   └── targets/
│       ├── vault.yml       # 🔐 ENCRYPTED secrets
│       └── vars.yml        # 📄 Public variables referencing vault
```

### vault.yml (encrypted)
Contains sensitive values:
```yaml
vault_mysql_password: "secure_password"
vault_mysql_root_password: "root_password"
vault_wp_admin_password: "admin_password"
```

### vars.yml (public)
References the secrets:
```yaml
mysql_password: "{{ vault_mysql_password }}"
mysql_root_password: "{{ vault_mysql_root_password }}"
```

## 🔄 Typical Workflow

### Local Development
```bash
# 1. Create .vault_pass once
echo "my_vault_password" > .vault_pass

# 2. Deploy without password prompt
make ansible-vault
```

### CI/CD (GitHub Actions)
```yaml
- name: Deploy with vault
  env:
    VAULT_PASS: ${{ secrets.ANSIBLE_VAULT_PASSWORD }}
  run: |
    echo "$VAULT_PASS" > .vault_pass
    make ansible-vault
```

### Team Collaboration
1. Share vault password securely
2. Each developer creates their own local `.vault_pass`
3. Never commit `.vault_pass`

## 🆘 Advanced Commands

### Change vault password
```bash
ansible-vault rekey ansible/group_vars/targets/vault.yml
```

### Permanently decrypt (NOT recommended)
```bash
ansible-vault decrypt ansible/group_vars/targets/vault.yml
```

### Re-encrypt
```bash
ansible-vault encrypt ansible/group_vars/targets/vault.yml
```

### Validate vault is correct
```bash
ansible-vault view ansible/group_vars/targets/vault.yml --vault-password-file .vault_pass
```

## ⚠️ Common Issues

### "ERROR! Attempting to decrypt but no vault secrets found"
- **Solution**: File is not encrypted. Run `make setup-vault`

### "ERROR! Decryption failed"
- **Solution**: Incorrect password. Check `.vault_pass` or enter the correct one

### "Vault password file not found"
- **Solution**: Create `.vault_pass` or use `--ask-vault-pass`

## 🔒 Security Best Practices

✅ **DO**:
- Encrypt ALL secrets (passwords, tokens, keys)
- Store vault password in a password manager
- Add `.vault_pass` to `.gitignore`
- Rotate passwords periodically
- Use strong passwords for the vault

❌ **DON'T**:
- Commit `.vault_pass`
- Share password via chat/email without encryption
- Use the same vault password for other services
- Store secrets in unencrypted files
- Leave decrypted files in the system

## 📚 Additional Resources

- [Ansible Vault Documentation](https://docs.ansible.com/ansible/latest/user_guide/vault.html)
- [Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#best-practices-for-variables-and-vaults)

## 🎯 Command Summary

```bash
# Initial setup
make setup-vault        # Encrypt secrets for the first time

# Daily usage
make ansible-vault      # Deploy with vault
make edit-vault         # Edit secrets
make view-vault         # View secrets

# Advanced
ansible-vault rekey ansible/group_vars/targets/vault.yml  # Change password
```

---

**Need help?** Check the official documentation or contact the team.
