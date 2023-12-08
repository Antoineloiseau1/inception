FROM alpine:3.17

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/configure.sh /configure.sh

CMD ["sh", "/configure.sh"]
