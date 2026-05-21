# Docker recipes for self-hosting Cerb

Self host [Cerb](https://cerb.ai/) using Docker.

## cerb-caddy-mysql (RECOMMENDED)

A full-stack Docker Compose installation of Cerb suitable for evaluation, development, and testing. Cerb file storage and the MySQL datadir are stored in local Docker volumes.

## cerb-nginx-mysql

A full-stack Docker Compose installation of Cerb suitable for evaluation, development, and testing. Cerb file storage and the MySQL datadir are stored in local Docker volumes.

## _base

This directory is only used to build custom base images.

### php-fpm

The `_base/php-fpm` directory builds the base image from the official `php:fpm` versioned image along with Cerb's required PHP extensions.

Building this image first drastically speeds up the build times of versioned Cerb images.

This image only needs to be rebuilt when updating the OS, PHP, or extension versions.

Most people do not need to build this image locally.

### cerb

The `_base/cerb` directory builds versioned Cerb images on top of `_base/php-fpm`.

This container uses PHP FastCGI Process Manager (PHP-FPM) and listens on port 9000. Do not expose this port publicly.

You must pair the container with a web server like [Caddy](https://hub.docker.com/_/caddy/) or [nginx](https://hub.docker.com/_/nginx/).

Unless you need a custom build of Cerb, use the pre-built tagged images from Docker Hub: http://hub.docker.com/repository/docker/cerb/cerb