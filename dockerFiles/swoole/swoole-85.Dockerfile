FROM php:8.5-cli-alpine


RUN apk update

RUN \
    apk add libpq zip bzip2 libzip libpng libwebp jpeg libbz2 icu-libs && \
    apk add --virtual .build-deps $PHPIZE_DEPS linux-headers libstdc++ postgresql-dev curl-dev openssl-dev pcre-dev pcre2-dev zlib-dev bzip2-dev libzip-dev libpng-dev jpeg-dev libwebp-dev libpq-dev icu-dev && \
    docker-php-source extract && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    docker-php-ext-configure gd --enable-gd --with-webp --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd sockets pcntl pdo_mysql pdo_pgsql pgsql bz2 zip mysqli exif intl bcmath && \
    \
    \
#    mkdir /usr/src/php/ext/swoole && \
#    curl -sfL https://github.com/swoole/swoole-src/archive/refs/tags/v6.1.4.tar.gz -o swoole.tar.gz && \
#    tar xfz swoole.tar.gz --strip-components=1 -C /usr/src/php/ext/swoole && \
#    docker-php-ext-configure swoole \
##        --enable-http2   \
#        --enable-mysqlnd \
#        --enable-openssl \
#        --enable-sockets && \
##        --enable-hook-curl \
##        --with-postgres && \
#    docker-php-ext-install -j$(nproc) --ini-name zzz-docker-php-ext-swoole.ini swoole && \
#    rm -f swoole.tar.gz $HOME/.composer/*-old.phar && \
    \
    pecl install swoole -D 'enable-sockets="yes" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="yes" enable-swoole-curl="yes" enable-cares="yes"'  && \
    echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini && \
    \
    docker-php-source delete && \
    apk del .build-deps

RUN apk add --update npm git

RUN \
    curl -sfL https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    chmod +x /usr/bin/composer && \
    composer self-update --clean-backups && \
    composer global require "laravel/installer" && \
    ln -s /root/.composer/vendor/bin/laravel /usr/local/bin/laravel && \
    cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

WORKDIR "/var/www/"