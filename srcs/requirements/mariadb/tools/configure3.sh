#!/bin/sh

#for socker errors
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

chown -R mysql:mysql /run/mysqld

#if DATABASE is not created
if [ ! -d "/var/lib/mysql/'${MYSQL_DATABASE}'" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	echo "initializing database"
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	#creating a temp file to store MYSQL configuration
	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	cat << EOF > $tfile
	USE mysql;
	FLUSH PRIVILEGES;

	DELETE FROM	mysql.user WHERE User='';
	DROP DATABASE test;
	DELETE FROM mysql.db WHERE Db='test';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';

	CREATE DATABASE $MYSQL_DATABASE;
	CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USR'@'%';

	FLUSH PRIVILEGES;
EOF
		# run init.sql
		mariadbd --user=mysql --bootstrap < $tfile
		rm -f $tfile
fi

exec mariadbd --user='${MYSQL_USR}' --console
