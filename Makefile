SRCS	=	srcs/docker-compose.yml

DOCKER	=	docker compose -f

CMD		=	up

all:
	${DOCKER} ${SRCS} ${CMD} -d

.PHONY:		all clean re
