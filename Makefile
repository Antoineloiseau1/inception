COMPOSE 	= srcs/docker-compose.yml
NGINX		= srcsrequirements//nginx
WORDPRESS	= srcs/requirements/wordpress
MARIADB		= srcs/requirements/mariadb

all:
	-mkdir -p /home/anloisea/data /home/anloisea/data/mysql /home/anloisea/data/wordpress
	docker compose -f $(COMPOSE) up -d

re: fclean all

down:
	docker compose -f $(COMPOSE) down

prune:
	docker system prune --force

fclean: stop down
	-docker rm -f $$(docker ps -a -q)
	-docker volume rm $$(docker volume ls -q)
	-docker system prune --force --all
	-docker volume prune --force
	-docker network prune --force
	-sudo rm -rf /home/anloisea/data

nginx:
	docker build --no-cache -t nginx $(NGINX)

wordpress:
	docker build --no-cache -t wordpress &(WORDPRESS)

mariadb:
	docker build --no-cache -t mariadb &(MARIADB)

stop:
	-docker stop $$(docker ps -qa)

.PHONY: all re nginx prune down fclean wordpress mariadb stop
