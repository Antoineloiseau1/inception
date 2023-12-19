#!/bin/sh

rc-service mariadb setup

rc-service mariadb start

mysql_secure_installation << _EOF_

Y
Y
\`${MYSQL_ROOT_PASSWORD}\`
\`${MYSQL_ROOT_PASSWORD}\`
Y
n
Y
Y
_EOF_

	mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"

rc-service mariadb stop

exec "$@"
