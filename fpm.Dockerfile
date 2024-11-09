FROM php:fpm-alpine

RUN apk update && apk upgrade
RUN \
    apk add --no-cache --virtual zlib1g-dev libpng-dev jpeg-dev libwebp-dev bzip2-dev libzip-dev openssl-dev libpq-dev && \
    docker-php-ext-configure gd --enable-gd --with-webp --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd bz2 zip pdo_mysql pdo_pgsql pgsql

EXPOSE 9000/tcp
CMD ["php-fpm"]