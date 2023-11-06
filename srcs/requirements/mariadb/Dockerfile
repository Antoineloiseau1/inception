FROM	debian:bullseye

RUN		apt update && apt upgrade
RUN		apt install -y mariadb-server
COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tool/create_db.sh /home/create_db.sh
