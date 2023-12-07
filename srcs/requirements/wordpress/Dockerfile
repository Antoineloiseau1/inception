FROM	debian:buster

RUN	apt update -y
RUN apt-get install -y curl
RUN apt-get install -y php-fpm php-mysql

COPY conf/script.sh /
COPY conf/www.conf /etc/php7.3/fpm/pool.d/www.conf
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY conf/wp-config.php /


#CMD ["sh", "script.sh"]
