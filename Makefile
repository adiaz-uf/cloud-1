all: create-venv install-deps

create-venv:
	python3 -m venv venv
	@printf "Virtual environment created!"

install-deps:
	venv/bin/pip install -r requirements.txt

# Ansible vault
ansible:
	@if [ -f .vault_pass ]; then \
		ansible-playbook -i ansible/inventory ansible/deploy.yml --vault-password-file .vault_pass; \
	else \
		ansible-playbook -i ansible/inventory ansible/deploy.yml --ask-vault-pass; \
	fi

setup-vault:
	@chmod +x scripts/setup-vault.sh
	@./scripts/setup-vault.sh

edit-vault:
	@chmod +x scripts/edit-vault.sh
	@./scripts/edit-vault.sh

view-vault:
	@chmod +x scripts/view-vault.sh
	@./scripts/view-vault.sh

.PHONY: all create-venv install-deps ansible ansible-vault setup-vault edit-vault view-vault
