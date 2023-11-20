FROM	alpine:3.17

RUN		apk update
RUN		apk upgrade
RUN		apk add mariadb
RUN		apk add openrc

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tools/configure.sh /home 

#CMD		["sh", "/home/configure.sh"]		
