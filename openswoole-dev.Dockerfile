FROM sichev/octane-openswoole:latest

RUN \
    cp -f /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
    apk add --no-cache linux-headers inetutils-telnet && \
    apk add --no-cache libstdc++ postgresql-dev libpq zip bzip2 libzip && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS curl-dev openssl-dev pcre-dev pcre2-dev zlib-dev bzip2-dev libzip-dev && \
    docker-php-source extract && \
    yes | pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    sed -i '1 a xdebug.discover_client_host=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    sed -i '1 a xdebug.client_host=host.docker.internal' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    sed -i '1 a xdebug.client_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    docker-php-source delete && \
    apk del .build-deps && \
    echo "Done."
