SRCS	=	./srcs/docker-compose.yml

all:
	# adding login.42.fr to localhost
	echo "127.0.0.1 anloisea.42.fr" >> /etc/hosts
	echo "127.0.0.1 www.anloisea.42.fr" >> /etc/hosts
	docker compose -f ${SRCS} up -d

down:
		docker compose -f ${SRCS} down

clean:
		docker stop $$(docker ps -aq); \
		docker container rm $$(docker ps -aq); \
		docker rmi -f $$(docker images -aq); \

re:		clean all

.PHONY:	all down re
