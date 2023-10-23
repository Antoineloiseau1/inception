FROM	alpine:3.17

RUN apk update
RUN apk upgrade
RUN apk add nginx
RUN apk add openssl
COPY conf/nginx.conf /etc/nginx/nginx.conf
