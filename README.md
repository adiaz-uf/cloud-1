# cloud-1
Automated deployment of WordPress (Inception project) on AWS EC2 using Ansible.

## 🚀 Quick Start

### 1. Create python enviroment and install dependencies

```bash
make
```

### 2. Setup Ansible Vault (First time only)
```bash
make setup-vault
```
This will encrypt your secrets with a password.

### 3. Deploy to AWS
```bash
# First: Update your EC2 IP in ansible/inventory
make ansible
```

### 4. Access your WordPress
```
https://<YOUR_EC2_IP>/wp-admin
```

## 🛠️ Available Commands

```bash
make setup-vault       # Encrypt secrets (first time)
make ansible           # Deploy to AWS with encrypted secrets
make edit-vault        # Edit encrypted secrets
make view-vault        # View secrets without editing
```

## 📁 Project Structure

```
.
├── ansible/
│   ├── group_vars/
│   │   └── targets/
│   │       ├── vault.yml
│   │       └── vars.yml
│   ├── roles/
│   │   ├── docker-setup/
│   │   ├── security/
│   │   └── wordpress-stack/
│   ├── deploy.yml
│   └── inventory
├── inception/
│   └── srcs/
│       ├── docker-compose.yml
│       └── requirements/
└─── scripts/
    ├── setup-vault.sh
    ├── edit-vault.sh
    └── view-vault.sh
```

## 🔒 Security

All sensitive data (passwords, credentials) are encrypted using Ansible Vault. 
Never commit `.vault_pass` or unencrypted secrets!
