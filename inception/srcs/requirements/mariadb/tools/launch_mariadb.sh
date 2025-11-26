#!/bin/bash

service mariadb start
mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'"
mariadb -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -u root
mysqld --bind-address=0.0.0.0 --port=3306 --user=root
