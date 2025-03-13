# Cerb, Caddy, MySQL, and Redis

A full-stack Docker Compose installation of Cerb suitable for evaluation, development, and testing.

Cerb file storage and the MySQL data-dir are stored in local Docker volumes.

Edit the `.env` file to configure the web server port and database credentials.

Edit `caddy/Caddyfile` to configure the web server (e.g. SSL).

Edit `php-fpm/www.conf` to scale PHP-FPM processes.

To launch: `docker compose up --build`

To completely remove: `docker compose down --volumes`

> [!WARNING]
> This template is not intended for production use. If public-facing, replace `CERB_INSTALL=yes` with `#CERB_INSTALL=yes` in the `.env` file after installation and restart the containers.