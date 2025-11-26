FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

COPY ./conf/default /etc/nginx/sites-available
COPY ./tools/launch_nginx.sh /var/www/

RUN chmod +x /var/www/launch_nginx.sh

EXPOSE 443 80

ENTRYPOINT [ "/var/www/launch_nginx.sh" ]

CMD ["nginx", "-g", "daemon off;"]
