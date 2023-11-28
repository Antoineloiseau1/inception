# MariaDB Dockerfile
FROM debian:bullseye

# Install MariaDB
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install mariadb-server mariadb-client -y

# Copy custom my.cnf
COPY conf/50-server.cnf /etc/mysql/50-server.cnf
COPY tools/configure.sh /tmp/configure.sh
RUN	chmod 644 /tmp/configure.sh

# Expose the default MySQL port
EXPOSE 3306


ENV MYSQL_DATABASE=wordpress
ENV	MYSQL_USR=anloisea
ENV	MYSQL_PASSWORD=born2code
ENV MYSQL_ROOT_PASSWORD=root4life

# Start MariaDB
#CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql", "--socket=/run/mysqld/mysqld.sock", "--port=3306"]
#CMD ["sh", "/tmp/configure.sh"]

