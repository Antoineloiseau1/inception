#!/bin/sh

mysql_install_db

if [-d "/var/lib/mysql/wp-content"]
then
	echo "Database already exists"
else

/etc/init.d/mysql start

mysql_secure_installation << _EOF_
 
Y
\`${MYSQL_ROOT_PASSWORD}\`
\`${MYSQL_ROOT_PASSWORD}\`
Y
n
Y
Y
_EOF_

sleep 3

	mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"

/etc/init.d/mysql stop

fi

exec "$@"
