all: create-venv install-deps

create-venv:
	python3 -m venv venv
	@printf "Virtual environment created!"

install-deps:
	venv/bin/pip install -r requirements.txt

ansible:
	ansible-playbook -i ansible/inventory ansible/deploy.yml

.PHONY: all create-venv install-deps ansible
