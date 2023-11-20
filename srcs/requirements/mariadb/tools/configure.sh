#! /bin/bash

service mariadb start

mariadb -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mariadb -e "CREATE USER IF NOT EXISTS '${DB_USR}'@'%' IDENTIFIED BY '${DB_PWD}';"
mariadb -e "GRANT ALL PRIVILEGES ON '${DB_NAME}'.* TO '${DB_USR}'@'%' IDENTIFIED BY '${DB_PWD}';"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';"
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$DB_ROOT_PWD shutdown

#exec mysqld_safe
