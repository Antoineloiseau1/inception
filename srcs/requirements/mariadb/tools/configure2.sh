#! /bin/bash

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


#mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
#echo	"database Created"
#mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USR}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#echo	"User ${MYSQL_USR} Created"
#mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USR}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#mariadb -e "FLUSH PRIVILEGES;"
#echo "all privileges granted"
#mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
#echo "root altered"

#mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

#exec mysqld_safe

cat << EOF > init_mariadb.sql
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
	CREATE USER IF NOT EXISTS '${MYSQL_USR}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USR}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
	FLUSH PRIVILEGES;
EOF

