#!/bin/bash

while ! mysql -u ${USER} -h mariadb --password=${ROOT_PASSWORD} -e "show databases;" | grep wordpress > /dev/null
do
  sleep 3
  echo "waiting for database connection"
done
if [ ! -f /usr/share/website/wp-config.php ]
then
  sudo -u ${USER} -i -- wp core download --path=/usr/share/website
  sudo -u "${USER}" -i -- wp config create --dbname=${DATABASE_NAME} --dbuser=${USER} \
  --dbhost=mariadb.vagrant_${NETWORK} --dbpass=${ROOT_PASSWORD} --path=/usr/share/website
  sudo -u ${USER} -i -- wp core install --url=${DOMAIN_NAME} --title=${NAME} \
  --admin_user=${USER} --admin_email=email@admin.ru --admin_password=${ROOT_PASSWORD} --path=/usr/share/website
  sudo -u "${USER}" -i -- wp user create user email@user.mail --role=subscriber --user_pass=${USER_PASSWORD} \
  --path=/usr/share/website/
  sudo -u "${USER}" -i -- wp plugin install redis-cache --activate --path=/usr/share/website/
  sudo -u "${USER}" -i -- wp config set WP_REDIS_HOST 'redis' --path=/usr/share/website/
  sudo -u "${USER}" -i -- wp config set WP_REDIS_PORT 6379 --path=/usr/share/website/
  sudo -u "${USER}" -i -- wp config set WP_REDIS_TIMEOUT 1 --path=/usr/share/website/
  sudo -u "${USER}" -i -- wp config set WP_REDIS_READ_TIMEOUT 1 --path=/usr/share/website/
  sudo -u "${USER}" -i -- wp config set WP_REDIS_DATABASE 0 --path=/usr/share/website/
  sudo -u "${USER}" -i -- wp redis enable --path=/usr/share/website/

fi
cat /etc/php/7.3/fpm/pool.d/www.conf | \
  sed "s/;access.log = log\/\$pool.access.log/access.log = \/var\/log\/\$pool.access.log/" | \
  sed "s/listen = \/run\/php\/php7.3-fpm.sock/listen = wordpress:9000/" | \
  sed "s/;listen.mode = 0660/listen.mode = 0660/" | \
  sed "s/user = www-data/user = ${USER}/" | \
  sed "s/group = www-data/group = ${USER_GROUP}/" | \
  sed "s/listen.owner = www-data/listen.owner = ${USER}/" | \
  sed "s/listen.group = www-data/listen.group = ${USER_GROUP}/" |\
  sed "s/;listen.allowed_clients = 127.0.0.1/;listen.allowed_clients = nginx.srcs_${NETWORK}/" >\
  "/etc/php/7.3/fpm/pool.d/temp.conf" \
  && mv /etc/php/7.3/fpm/pool.d/temp.conf /etc/php/7.3/fpm/pool.d/www.conf

supervisord -c supervisord.conf

