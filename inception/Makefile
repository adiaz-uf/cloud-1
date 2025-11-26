all:
	@mkdir -p /home/adiaz-uf/data/mysql
	@mkdir -p /home/adiaz-uf/data/wordpress
	@mkdir -p /home/adiaz-uf/data/phpmyadmin
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

fclean:
	@sudo rm -rf /home/adiaz-uf/data/mysql/*
	@sudo rm -rf /home/adiaz-uf/data/wordpress/*
	@sudo rm -rf /home/adiaz-uf/data/phpmyadmin/*
	@docker stop $$(docker ps -qa) 2>/dev/null || true
	@docker rm $$(docker ps -qa) 2>/dev/null || true
	@docker rmi $$(docker images -qa) 2>/dev/null || true
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network rm network 2>/dev/null || true

re: fclean all

.PHONY: all down clean
