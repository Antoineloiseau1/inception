#!/bin/bash

# create directory to use in nginx container later and also to set up the WordPress conf
mkdir -p /var/www/html

cd /var/www/html

rm -rf *


curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

rm /var/www/html/wp-config-sample.php 

# Replace MariaDB info with env variables in wp-config
sed -i 's/database_name_here/'$MYSQL_DATABASE'/1' /wp-config.php
sed -i 's/username_here/'$MYSQL_USR'/1' /wp-config.php
sed -i 's/password_here/'$MYSQL_PASSWORD'/1' /wp-config.php
sed -i 's/localhost/mariadb:3306/1' /wp-config.php

mv /wp-config.php /var/www/html/wp-config.php

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

wp theme install astra --activate --allow-root

wp plugin install redis-cache --activate --allow-root

wp plugin update --all --allow-root

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = wordpress:9000/g' /etc/php/7.3/fpm/pool.d/www.conf
sed -i 's/;clear_env = no/clear_env = no/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir -p /run/php

wp redis enable --allow-root

/usr/sbin/php-fpm7.3 -F

