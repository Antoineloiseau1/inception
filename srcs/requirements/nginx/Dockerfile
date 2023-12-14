FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl
				
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
					-out /etc/nginx/ssl/server.crt\
					-keyout /etc/nginx/ssl/server.key\
					-subj "/C=FR/ST=PACA/L=Nice/O=42/OU=Student/CN='${DOMAIN_NAME}'/UID=anloisea@student.42nice.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
