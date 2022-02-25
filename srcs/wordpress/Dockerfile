FROM debian:buster
WORKDIR /
RUN apt-get -y update && apt-get -y install php supervisor php-fpm curl sudo mariadb-client php-mysql sendmail
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
ARG USER
ARG ROOT_PASSWORD
ARG USER_GROUP
RUN groupadd --gid=1154 "${USER_GROUP}"
RUN useradd --create-home -g "${USER_GROUP}" --groups=sudo --uid=154 --password="${ROOT_PASSWORD}" "${USER}"
RUN mkdir /run/php
ADD conf/supervisord.conf .
ADD conf/start.sh .
RUN service php7.3-fpm start
RUN service php7.3-fpm stop
RUN chmod +x start.sh