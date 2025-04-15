#!/bin/bash


#if [ ! -d "/var/lib/mysql/mysql" ]; then
#    
#    service mariadb start
#
#    mysql_upgrade --force > /dev/null
#    mysql_install_db --user=mysql --datadir=/var/lib/mysql
#    #mariadbd --log-error=/dev/stderr --general-log --general-log-file=/dev/stdout &
#    #sleep 5
#    
#    mysql -u root << EOF
#ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
#FLUSH PRIVILEGES;
#EOF
#fi
#
#mysql -u root -p"${MYSQL_ROOT_PASSWORD}" << EOF
#CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
#CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
#GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
#FLUSH PRIVILEGES;
#EOF
#
#
#service mariadb stop && mariadb --user=mysql

#exec mariadbd --log-error=/dev/stderr --general-log --general-log-file=/dev/stdout

#-----------------------------------------------------------------

mysqld_safe &

until mysqladmin ping --silent; do
  echo "Mariadb not ready yet."
  sleep 2
done


mysql -u root -p"${MYSQL_ROOT_PASSWORD}" << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
echo "Starting mariadb"
mysqld
