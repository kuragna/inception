#!/bin/bash

WORDPRESS_PATH=/var/www/html

if [ ! -f ${WORDPRESS_PATH}/wp-config.php ]; then

  echo "WordPress is not installed"
  wp core download --path=${WORDPRESS_PATH} --allow-root

  chown -R www-data:www-data ${WORDPRESS_PATH}
  find ${WORDPRESS_PATH} -type d -exec chmod 755 {} \;
  find ${WORDPRESS_PATH} -type f -exec chmod 644 {} \;

  
  # setting database information
  wp config create \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=${WORDPRESS_DB_HOST} \
    --path=${WORDPRESS_PATH} \
    --allow-root

  wp core install \
    --url=https://${DOMAIN_NAME} \
    --title=${WORDPRESS_TITLE}\
    --admin_user=${WORDPRESS_ADMIN_USER} \
    --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
    --admin_email=${WORDPRESS_ADMIN_EMAIL} \
    --path=${WORDPRESS_PATH} \
    --allow-root

  wp user create \
    ${WORDPRESS_USER} \
    ${WORDPRESS_USER_EMAIL} \
    --user_pass=${WORDPRESS_USER_PASSWORD} \
    --role="author" \
    --allow-root
  
  chown -R www-data:www-data ${WORDPRESS_PATH}
  find ${WORDPRESS_PATH} -type d -exec chmod 755 {} \;
  find ${WORDPRESS_PATH} -type f -exec chmod 644 {} \;
  
  echo "WordPress installation completed!"
fi

echo "Starting wordpress"
php-fpm8.2 --nodaemonize
