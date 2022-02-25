FROM debian:buster
RUN apt-get -y update && apt-get -y install nginx openssl supervisor curl libfcgi0ldbl
ADD conf/nginx-selfsigned.crt /etc/ssl/certs/
ADD conf/nginx-selfsigned.key /etc/ssl/private/
ADD conf/nginx.conf /etc/nginx
ADD conf/default    /etc/nginx/sites-enabled
ADD conf/start.sh .
RUN chmod +x start.sh
ADD conf/error.css /usr/share/nginx/html
ADD conf/error.html /usr/share/nginx/html
ADD conf/supervisord.conf .