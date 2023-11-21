SRCS	=	./srcs/docker-compose.yml

all:
	# adding login.42.fr to localhost
	echo "127.0.0.1 anloisea.42.fr" >> /etc/hosts
	docker compose -f ${SRCS} up -d --build

down:
		docker compose -f ${SRCS} down

clean:
		docker stop $$(docker ps -aq); \
		docker container rm $$(docker ps -aq); \
		docker rmi -f $$(docker images -aq); \
		docker volume rm $$(docker volume ls -q); \
		docker network rm $$(docker network ls -q); \

re:		clean all

.PHONY:	all down re
