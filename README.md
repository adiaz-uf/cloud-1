# cloud-1

Automated deployment of WordPress (Inception project) on AWS EC2 using Ansible.

## 🚀 Quick Start

### 1. Create python environment and install dependencies

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

> Ansible will then connect to your EC2 instance, install Docker, and deploy WordPress with Docker Compose.

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

# Team work 💪

This project was a team effort. You can checkout the team members here:

-   **Alejandro Díaz Ufano Pérez**
    -   [Github](https://github.com/adiaz-uf)
    -   [LinkedIn](https://www.linkedin.com/in/alejandro-d%C3%ADaz-35a996303/)
    -   [42 intra](https://profile.intra.42.fr/users/adiaz-uf)
-   **Alejandro Aparicio**
    -   [Github](https://github.com/magnitopic)
    -   [LinkedIn](https://www.linkedin.com/in/magnitopic/)
    -   [42 intra](https://profile.intra.42.fr/users/alaparic)
