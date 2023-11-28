SRCS	=	./srcs/docker-compose.yml

all:
	# adding login.42.fr to localhost
	# sudo echo "127.0.0.1 anloisea.42.fr" >> /etc/hosts
	docker compose -f ${SRCS} up -d --build

down:
		docker compose -f ${SRCS} down

clean:
		docker -f srcs/docker-compose.yml down \
		docker volume rm $$(docker volume ls -q); \
		docker network rm $$(docker network ls -q); \

re:		down all

.PHONY:	all down clean re
