SRCS	=	./srcs/docker-compose.yml

all:
		docker compose -f ${SRCS} up -d --build

down:
		docker compose -f ${SRCS} down -v

clean:	down
		docker network rm $$(docker network ls -q); \

re:		down all

.PHONY:	all down clean re
