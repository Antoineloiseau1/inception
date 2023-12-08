#!/bin/sh

chmod 755 /var/tmp

chown -R mysql:mysql /var/tmp

#for socket errors
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

mkdir -p /var/log/mysql/
chown -R mysql:mysql /var/log/mysql

mkdir -p /var/lib/mysql 
chown -R mysql:mysql /var/lib/mysql


#if DATABASE is not created
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
	# To create temporary file
	file="/tmp/aled"

	# Fill the tmp file with MySql commands.
	cat << EOF > $file
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS '$MYSQL_DATABASE';
CREATE USER $MYSQL_USR@'%' IDENTIFIED by '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO $MYSQL_USR@'%';
FLUSH PRIVILEGES;
EOF

	# Use the tmp file to configure the database then remove it.
	/usr/bin/mysqld --user=mysql --bootstrap < $file
	rm -f $file
fi

# Allow network use.
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

# Listen all network interfaces.
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec mysqld --user=$MYSQL_USR --console
