FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install php-mysql curl php-fpm mariadb-client -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/

COPY conf/www.conf			  /etc/php/8.2/fpm/pool.d/
COPY conf/php.ini 			  /etc/php/8.2/cli/
COPY tools/start-wordpress.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/start-wordpress.sh

CMD ["/usr/local/bin/start-wordpress.sh"]
