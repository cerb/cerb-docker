# cerb

The `cerb` directory builds versioned Cerb images on top of `cerb:base-8.3-fpm`.

This container uses PHP FastCGI Process Manager (PHP-FPM) and listens on port 9000. Do not expose this port publicly.

Mount a Docker volume or shared filesystem (EFS) to `/mnt/storage` for persistence.

You must pair the container with a web server like [Caddy](https://hub.docker.com/_/caddy/) or [nginx](https://hub.docker.com/_/nginx/).

See the examples at: https://github.com/cerb/cerb-docker/

Unless you need a custom build of Cerb, use the pre-built tagged images from Docker Hub: http://hub.docker.com/repository/docker/cerb/cerb

```bash
docker build -t cerb:11.0 --build-arg CERB_BRANCH="v11.0" --platform=linux/arm64,linux/amd64 .
```