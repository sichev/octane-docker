FROM php:cli-alpine


RUN \
    curl -sfL https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    chmod +x /usr/bin/composer && \
    composer self-update --clean-backups && \
    apk update && \
    apk add --no-cache linux-headers && \
    apk add --no-cache libstdc++ postgresql-dev libpq zip bzip2 libzip && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS curl-dev openssl-dev pcre-dev pcre2-dev zlib-dev bzip2-dev libzip-dev && \
    docker-php-ext-install sockets pcntl pdo_mysql pdo_pgsql pgsql bz2 zip && \
    docker-php-source extract && \
    mkdir /usr/src/php/ext/openswoole && \
    curl -sfL https://github.com/openswoole/ext-openswoole/archive/v22.1.2.tar.gz -o openswoole.tar.gz && \
    tar xfz openswoole.tar.gz --strip-components=1 -C /usr/src/php/ext/openswoole && \
    docker-php-ext-configure openswoole \
        --enable-http2   \
        --enable-mysqlnd \
        --enable-openssl \
        --enable-sockets --enable-hook-curl --with-postgres && \
    docker-php-ext-install -j$(nproc) --ini-name zzz-docker-php-ext-openswoole.ini openswoole && \
    rm -f openswoole.tar.gz $HOME/.composer/*-old.phar && \
    docker-php-source delete && \
    apk del .build-deps && \
    apk add --update npm

WORKDIR "/var/www/"