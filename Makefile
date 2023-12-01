SRCS	=	./srcs/docker-compose.yml

all:
		docker compose -f ${SRCS} up -d --build

down:
		docker compose -f ${SRCS} down

clean:
		docker -f srcs/docker-compose.yml down \
		docker volume rm $$(docker volume ls -q); \
		docker network rm $$(docker network ls -q); \

re:		down all

.PHONY:	all down clean re
