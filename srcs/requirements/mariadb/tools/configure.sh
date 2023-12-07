#!/bin/bash

if [ ! -d "/var/run/mysqld" ]; then
	mkdir -p /var/run/mysqld
fi

if [ ! -d "/run/mysqld" ]; then
	mkdir -d /run/mysqld
fi

chown -R mysql:mysql /var/run/mysqld
chmod 777 /var/run/mysqld
chown -R mysql:mysql /run/mysqld
chmod 777 /run/mysqld

service mysql start 

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > configure.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USR'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> configure.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USR'@'%' ;" >> configure.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> configure.sql
echo "FLUSH PRIVILEGES;" >> configure.sql

mysql < configure.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
