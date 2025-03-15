FROM php:8.3-fpm

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apt-get update && apt-get upgrade -y

RUN apt-get -y install \
    git \
    gettext-base

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libfreetype-dev \
    libgmp-dev \
    libjpeg62-turbo-dev \
    libonig-dev \
    libpng-dev \
    libtidy-dev \
    libxml2-dev \
    libyaml-dev \
    libz-dev \
    libzip-dev \
  && docker-php-ext-install bcmath \
  && docker-php-ext-install curl \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd \
  && docker-php-ext-install gmp \
  && docker-php-ext-install mbstring \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install opcache \
  && docker-php-ext-install tidy \
  && docker-php-ext-install zip \
  && pecl install redis-6.1.0 \
  && pecl install mailparse-3.1.8 \
  && pecl install yaml-2.2.4 \
  && docker-php-ext-enable mailparse redis yaml
