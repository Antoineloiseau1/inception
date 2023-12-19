FROM debian:bullseye

RUN apt-get update && apt-get install -y \
				curl \
				php \
				php-cgi \
				php-mysql \
				php-fpm \
				&& rm -rf /var/lib/apt/lists/*
				
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir /run/php

RUN mkdir -p /var/www/html

COPY ./tools/create_wordpress.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/create_wordpress.sh

ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

WORKDIR /var/www/html/

CMD ["/usr/sbin/php-fpm7.4", "-F"]
