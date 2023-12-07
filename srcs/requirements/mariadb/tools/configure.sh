#!/bin/sh

#for socket errors
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

chown -R mysql:mysql /run/mysqld

#if DATABASE is not created
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	mysqld --user=mysql --bootstrap <<EOF
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USR'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USR'@'%';

FLUSH PRIVILEGES;
EOF
fi

exec mysqld --user=$MYSQL_USR --console
