FROM debian:buster

# Install MariaDB
RUN apt-get update -y
RUN apt-get install mariadb-server -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/my.cnf
COPY tools/configure.sh / 

#ENV MYSQL_DATABASE=wordpress
#ENV	MYSQL_USR=anloisea
#ENV	MYSQL_PASSWORD=born2code
#ENV MYSQL_ROOT_PASSWORD=root4life

CMD ["sh", "/configure.sh"]
