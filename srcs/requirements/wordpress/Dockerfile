FROM	debian:buster

RUN	apt update -y
RUN apt-get install -y curl
RUN apt-get install -y php-fpm php-mysql

COPY conf/script.sh /
COPY conf/wp-config.php /

CMD ["sh", "script.sh"]
