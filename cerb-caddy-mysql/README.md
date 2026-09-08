# Cerb, Caddy, MySQL, and Redis

A full-stack Docker Compose installation of Cerb suitable for evaluation, development, and testing.

Cerb file storage and the MySQL data-dir are stored in local Docker volumes.

Edit the `.env` file to configure the web server port and database credentials.

Edit `caddy/Caddyfile` to configure the web server. By default Cerb is served over plain HTTP to avoid self-signed certificate warnings during local development. To enable HTTPS, copy `caddy/Caddyfile.ssl.example` over `caddy/Caddyfile` and restart the `caddy` container.

## PHP-FPM pools

Cerb runs two PHP-FPM pools, and the split is by container rather than by port
— both listen on `9000`, and the `cerb` and `cerb-background` services
run the same image, differing only by `CERB_FPM_POOL`.

| Service | Pool | Handles |
| --- | --- | --- |
| `cerb` | `www` | Page loads and ajax. Milliseconds per request. |
| `cerb-background` | `background` | Drains: `/queue` and `/cron` only. |

Drains are routed away from the web pool precisely so that a single request
holding a child for the length of an agent turn — up to 900 seconds — can never
occupy a child that a page load needs. Everything else, including the API, file
uploads and downloads, stays on the web pool.

Caddy picks the pool from the request path in `caddy/Caddyfile`, before the
rewrite to the front controller. When the background pool is full it refuses
fast, and Caddy translates that into a `529` with a `Retry-After`.

Set `CERB_WEB_CHILDREN` and `CERB_BACKGROUND_CHILDREN` in `.env` to size each
pool. Background capacity is better added as replicas than as children, since a
drain worker spends its time blocked on curl rather than on CPU:

```
docker compose up --scale cerb-background=3
```

To run everything on one pool instead, set `CERB_FPM_BACKGROUND=cerb:9000`
in `.env`. Nothing else has to change.

To launch: `docker compose up --build`

To completely remove: `docker compose down --volumes`

> [!WARNING]
> This template is not intended for production use. If public-facing, replace `CERB_INSTALL=yes` with `#CERB_INSTALL=yes` in the `.env` file after installation and restart the containers.