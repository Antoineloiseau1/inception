FROM	alpine:3.17

RUN 	apk add --update --no-cache nginx openssl

ARG		CERTS_
ARG		DOMAIN_NAME

#		create a ssl certificate
RUN		mkdir -p ${CERTS_}

RUN		openssl req -x509 -nodes \ 
			-out ${CERTS_}/server.crt \ 
			-keyout ${CERTS_}/server.key \
			-subj "/C=FR/ST=PACA/L=Nice/O=42/OU=Student/CN='${DOMAIN_NAME}'/UID=anloisea@student.42nice.fr"
#optionnal but sercure ?
RUN			chmod 400 ${CERTS_}/server.crt
RUN			chmod 400 ${CERTS_}/server.key

COPY 		conf/nginx.conf /etc/nginx/nginx.conf

RUN			mkdir -p /var/www/html
RUN 		chmod 755 /var/www/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
