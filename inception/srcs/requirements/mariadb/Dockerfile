FROM debian:bullseye

RUN apt update -y && apt-get install  mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY ./tools/launch_mariadb.sh /usr/local/bin/

EXPOSE 3306

RUN mkdir /run/mysqld && chmod +x /usr/local/bin/launch_mariadb.sh

ENTRYPOINT ["/usr/local/bin/launch_mariadb.sh"]
