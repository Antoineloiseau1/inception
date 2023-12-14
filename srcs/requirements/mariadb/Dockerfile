FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server 
RUN apt-get install -y mariadb-client

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld 
RUN chmod 777 /var/run/mysqld


COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
