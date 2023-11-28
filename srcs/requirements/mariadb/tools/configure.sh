#! /bin/bash

if [ ! -d "/var/run/mysqld" ]; then
	mkdir -p /var/run/mysqld
fi

chown mysql:mysql /var/run/mysqld
chmod 777 /var/run/mysqld

service mariadb start

mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
echo	"database Created"
mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USR}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
echo	"User ${MYSQL_USR} Created"
mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USR}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"
echo "all privileges granted"
mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
echo "root altered"

#mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

#exec mysqld_safe
