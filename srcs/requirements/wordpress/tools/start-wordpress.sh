#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
  echo "WordPress is not installed"
  
  wp core download --path=/var/www/html --allow-root

  chown -R www-data:www-data /var/www/html
  find /var/www/html -type d -exec chmod 755 {} \;
  find /var/www/html -type f -exec chmod 644 {} \;

  
  
  wp config create \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=${WORDPRESS_DB_HOST}\
    --path=/var/www/html \
    --allow-root

  wp core install \
    --url=https://${DOMAIN_NAME} \
    --title=${WORDPRESS_TITLE}\
    --admin_user=${WORDPRESS_ADMIN_USER} \
    --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
    --admin_email=${WORDPRESS_ADMIN_EMAIL} \
    --path=/var/www/html \
    --allow-root
  
  chown -R www-data:www-data /var/www/html
  find /var/www/html -type d -exec chmod 755 {} \;
  find /var/www/html -type f -exec chmod 644 {} \;
  
  echo "WordPress installation completed!"
fi

echo "Starting wordpress"

php-fpm8.2 --nodaemonize
