#!/bin/bash

export $(cat /vagrant/.env | xargs)
echo "wordpress"
sudo docker exec -it wordpress service php7.3-fpm status
echo "nginx"
sudo docker exec -it wordpress curl https://nginx:443
echo "mariadb"
sudo docker exec -it wordpress mysql -u ${USER} -h mariadb --password=${ROOT_PASSWORD} -e "show databases;"
read -p "show logs?(y/n): " log
if [ $log == 'y' ]
then
  sudo docker exec -it mariadb cat /var/log/mysql/error.log
  sudo docker exec -it nginx cat /var/log/nginx/access.log
  sudo docker exec -it nginx cat /var/log/nginx/error.log
  sudo docker exec -it wordpress cat /var/log/www.access.log
fi
