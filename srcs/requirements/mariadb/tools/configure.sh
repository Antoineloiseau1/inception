#!/bin/bash

service mysql start 

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > configure.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USR'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> configure.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USR'@'%' ;" >> configure.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> configure.sql
echo "FLUSH PRIVILEGES;" >> configure.sql

mysql < configure.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
