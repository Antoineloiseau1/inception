FROM	alpine:3.17

RUN 	apk update
RUN 	apk upgrade
RUN 	apk add nginx
RUN 	apk add openssl
RUN		mkdir /etc/nginx/ssl
RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/server.crt -keyout /etc/nginx/ssl/server.key -subj "/C=FR/ST=PACA/L=Nice/O=42/OU=Student/CN=anloisea.42.fr/UID=anloisea@student.42nice.fr"
RUN		chmod 400 /etc/nginx/ssl/server.crt
RUN		chmod 400 /etc/nginx/ssl/server.key
COPY 	conf/nginx.conf /etc/nginx/nginx.conf
#CMD		["nginx", "-g", "daemon off;"]
