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
	-docker image rm $$(docker images -aq)
	-docker volume rm $$(docker volume ls -q)
	-docker metwork rm $$(docker network ls -q)

stop:
	-docker stop $$(docker ps -qa)

.PHONY: all re prune down fclean stop
