#!/bin/bash

#chown -R mysql:mysql /var/lib/mysql #/wordpress
cat /etc/mysql/mariadb.conf.d/50-server.cnf | \
  sed "s/#general_log_file       = \/var\/log\/mysql\/mysql.log/general_log_file       = \/var\/log\/mysql\/mysql.log/" | \
  sed "s/#general_log            = 1/general_log            = 1/" | \
  sed "s/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/" > \
  temp.cnf && mv temp.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start && \
echo "CREATE USER IF NOT EXISTS '${NEW_USER}'@'wordpress.vagrant_${NETWORK}' IDENTIFIED BY '${ROOT_PASSWORD}';" | mysql && \
echo "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};" | mysql && \
echo "GRANT ALL PRIVILEGES ON *.* TO '${NEW_USER}'@'wordpress.vagrant_${NETWORK}';" | mysql && \
#echo "GRANT ALL PRIVILEGES ON *.* TO '${NEW_USER}'@'%';" | mysql && \
#echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';" | mysql && \
echo "CREATE USER IF NOT EXISTS 'adminer'@'%' IDENTIFIED BY '${ROOT_PASSWORD}';" | mysql && \
echo "GRANT ALL PRIVILEGES ON *.* TO 'adminer'@'%';" | mysql && \
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" | mysql && \
kill $(ps -aux | grep "^mysql" | gawk '{ print $2 }') && \
service mysql stop
supervisord -c supervisord.conf