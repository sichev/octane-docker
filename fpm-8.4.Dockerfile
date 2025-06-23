FROM php:8.4-fpm-alpine

RUN apk update && apk upgrade

RUN \
    apk add libpng libwebp jpeg && \
    apk add --no-cache --virtual zlib1g-dev libpng-dev jpeg-dev libwebp-dev bzip2-dev libzip-dev openssl-dev libpq-dev && \
    docker-php-ext-configure gd --enable-gd --with-webp --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd bz2 zip pdo_mysql pdo_pgsql pgsql mysqli exif && \
    apk del zlib1g-dev libpng-dev jpeg-dev libwebp-dev bzip2-dev libzip-dev openssl-dev libpq-dev

RUN \
    apk add --no-cache --virtual pcre-dev ${PHPIZE_DEPS} && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    apk del pcre-dev ${PHPIZE_DEPS}

RUN apk add --update npm
RUN apk add --update git
RUN apk add --update vim
RUN apk add --update zip
RUN apk add --update net-tools

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require "laravel/installer" && \
    ln -s /root/.composer/vendor/bin/laravel /usr/local/bin/laravel && \
    cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
