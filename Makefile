SRCS	=	srcs/docker-compose.yml

DOCKER	=	docker compose -f

CMD		=	up

all:
	${DOCKER} ${SRCS} ${CMD} -d

clean:
	docker container prune -f
	docker image prune -af

.PHONY:		all clean re
