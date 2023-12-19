FROM alpine:3.18

RUN apk update
RUN apk upgrade

#installing and setting openrc
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN openrc

RUN apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld 
RUN chmod 777 /run/mysqld

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mariadbd"]
