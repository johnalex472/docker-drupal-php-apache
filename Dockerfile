FROM php:7.2-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
    libjpeg-dev \
    libpng-dev \
    libpq-dev

RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install -j "$(nproc)" \
        gd \
        opcache \
        pdo_mysql \
        zip

RUN docker-php-source extract \
    && cp /usr/src/php/php.ini-development /usr/local/etc/php/php.ini \
    && docker-php-source delete

COPY php/drupal.ini /usr/local/etc/php/conf.d/

COPY apache/drupal.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www
RUN usermod -u 1000 www-data
