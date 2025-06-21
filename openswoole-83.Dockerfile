FROM php:8.3-cli-alpine

RUN \
    apk update && \
    apk add --no-cache libpq zip bzip2 libzip && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS linux-headers libstdc++ postgresql-dev curl-dev openssl-dev pcre-dev pcre2-dev zlib-dev bzip2-dev libzip-dev libpng-dev jpeg-dev libwebp-dev libpq-dev && \
    docker-php-ext-configure gd --enable-gd --with-webp --with-jpeg && \
    docker-php-ext-install gd sockets pcntl pdo_mysql pdo_pgsql pgsql bz2 zip mysqli exif && \
    docker-php-source extract && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    mkdir /usr/src/php/ext/openswoole && \
    curl -sfL https://github.com/openswoole/ext-openswoole/archive/v22.1.2.tar.gz -o openswoole.tar.gz && \
    tar xfz openswoole.tar.gz --strip-components=1 -C /usr/src/php/ext/openswoole && \
    docker-php-ext-configure openswoole \
        --enable-http2   \
        --enable-mysqlnd \
        --enable-openssl \
        --enable-sockets \
        --enable-hook-curl \
        --with-postgres && \
    docker-php-ext-install -j$(nproc) --ini-name zzz-docker-php-ext-openswoole.ini openswoole && \
    rm -f openswoole.tar.gz $HOME/.composer/*-old.phar && \
    docker-php-source delete && \
    apk del .build-deps pcre-dev ${PHPIZE_DEPS}

RUN \
    apk add --update npm git

RUN \
    curl -sfL https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    chmod +x /usr/bin/composer && \
    composer self-update --clean-backups && \
    composer global require "laravel/installer" && \
    ln -s /root/.composer/vendor/bin/laravel /usr/local/bin/laravel && \
    cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

WORKDIR "/var/www/"