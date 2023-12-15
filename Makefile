COMPOSE 	= srcs/docker-compose.yml

all:
	-mkdir -p /home/anloisea/data /home/anloisea/data/mariadb /home/anloisea/data/wordpress
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

stop:
	-docker stop $$(docker ps -qa)

.PHONY: all re prune down fclean stop
