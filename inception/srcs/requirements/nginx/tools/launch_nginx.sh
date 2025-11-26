#!/bin/bash

DOMAIN=${DOMAIN_NAME:-adiaz-uf.42.fr}

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    echo "Nginx: setting up TLSv1.3 for domain ${DOMAIN}...";
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt \
        -subj "/C=ES/ST=Madrid/L=Madrid/O=wordpress/CN=${DOMAIN}";
    echo "Nginx: TLSv1.3 is set up!";
fi

exec "$@"
