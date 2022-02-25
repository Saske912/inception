FROM debian:buster
WORKDIR /
RUN groupadd --gid=1155 mysql
RUN useradd  -g mysql --uid=155 mysql
RUN apt-get -y update && apt-get -y install mariadb-server=1:10.3.31-0+deb10u1 supervisor procps python3.7
ADD conf/start.sh .
RUN chmod +x start.sh
ADD conf/supervisord.conf .
EXPOSE 3306
RUN chmod +x supervisord.conf