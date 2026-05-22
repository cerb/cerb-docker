FROM php:8.5-fpm

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
  && docker-php-ext-install tidy \
  && docker-php-ext-install zip \
  && pecl install redis-6.3.0 \
  && pecl install mailparse-3.2.0 \
  && pecl install yaml-2.3.0 \
  && docker-php-ext-enable mailparse redis yaml

RUN apt-get purge -y --auto-remove \
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
  && apt-get install -y --no-install-recommends \
    libcurl4 \
    libfreetype6 \
    libgmpxx4ldbl \
    libjpeg62-turbo \
    libonig5 \
    libpng16-16t64 \
    libtidy58 \
    libxml2 \
    libyaml-0-2 \
    zlib1g \
    libzip5 \
  && apt-get autoremove -y --purge