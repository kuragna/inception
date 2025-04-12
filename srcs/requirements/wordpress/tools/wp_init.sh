#!/bin/bash

wp core download --allow-root

mv ./wp-config-sample.php ./wp-config.php

sed -i -r "s/database_name_here/$MYSQL_DATABASE/1"  /var/www/html/wp-config.php
sed -i -r "s/username_here/$MYSQL_USER/1" /var/www/html/wp-config.php
sed -i -r "s/password_here/$MYSQL_PASSWORD/1"   /var/www/html/wp-config.php
sed -i -r "s/localhost/$WORDPRESS_DB_HOST/1"   /var/www/html/wp-config.php

until mysql -h $WORDPRESS_DB_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -e 'SELECT 1' 2> /dev/null; do
	>&2 echo "--- mariadb is not ready yet! ---"
	sleep 1
done

wp core install \
		--url=$DOMAIN_NAME \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL \
		--skip-email \
		--allow-root

wp user create \
		$WORDPRESS_DB_USER \
		$WP_USER_EMAIL \
		--role=author \
		--user_pass=WORDPRESS_DB_PASSWORD \
		--allow-root

echo "--- starting wordpress ---"
php-fpm8.2 --nodaemonize
