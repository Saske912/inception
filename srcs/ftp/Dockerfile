FROM debian:buster
ARG USER=pfile
ARG ROOT_PASSWORD=secure_password
ARG USER_GROUP=pfile
ARG IP=0.0.0.0
RUN apt-get -y update && apt-get install -y vsftpd openssl
ADD conf/vsftpd.conf /etc
RUN chown root /etc/vsftpd.conf
RUN mkdir -p /var/run/vsftpd/empty
RUN openssl req -x509 -newkey rsa:2048 \
    	-keyout /etc/ssl/private/ssl-cert-snakeoil.key \
    	-out /etc/ssl/certs/service.crt -nodes -days 365 \
    	-subj "/C=RU/ST=Voronezh/O=21school/OU=pfile/CN=${IP}"
EXPOSE 20
EXPOSE 21
EXPOSE 30020
EXPOSE 30021
RUN adduser pfile --disabled-password --uid=154; echo "${USER}:${ROOT_PASSWORD}" | chpasswd
CMD vsftpd /etc/vsftpd.conf