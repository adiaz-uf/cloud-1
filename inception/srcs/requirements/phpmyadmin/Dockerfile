FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    wget \
    php \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-zip \
    php-gd \
    php-json \
    php-curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/phpmyadmin

WORKDIR /var/www/phpmyadmin

# PHP-FPM config
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    mkdir -p /run/php

COPY ./tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9000

CMD ["/start.sh"]