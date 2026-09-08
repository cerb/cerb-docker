#!/bin/bash
# Install exactly one pool, the `sites-available` idiom -- so a
# `docker exec <container> ls /etc/php/8.5/fpm/pool.d/` says which role this
# container is running. Both pools listen on 9000; the split is by container,
# not by port, so there is no port to arbitrate.
CERB_FPM_POOL="${CERB_FPM_POOL:-www}"
CERB_WEB_CHILDREN="${CERB_WEB_CHILDREN:-6}"
CERB_BACKGROUND_CHILDREN="${CERB_BACKGROUND_CHILDREN:-4}"
export CERB_WEB_CHILDREN CERB_BACKGROUND_CHILDREN

set -e \
&& chown www-data:www-data /mnt/storage \
&& chmod 0770 /mnt/storage \
&& envsubst "\$CERB_DB_HOST \$CERB_DB_NAME \$CERB_DB_USER \$CERB_DB_PASS \$CERB_SERVICE_TOKEN \$CERB_SERVICE_TOKEN_SCOPE \$CERB_PROXY_HOST \$CERB_PROXY_PORT" \
  < /etc/cerb/framework.config.template.php > /var/www/html/framework.config.php \
&& if [ -z ${CERB_DB_HOST} ]; then echo "Error: CERB_DB_HOST is required."; exit 1; fi \
&& if [ -z ${CERB_DB_NAME} ]; then echo "Error: CERB_DB_NAME is required."; exit 1; fi \
&& if [ -z ${CERB_DB_USER} ]; then echo "Error: CERB_DB_USER is required."; exit 1; fi \
&& if [ -z ${CERB_DB_PASS} ]; then echo "Error: CERB_DB_PASS is required."; exit 1; fi \
&& if [ ! -f "/etc/php/8.5/fpm/pools-available/${CERB_FPM_POOL}.conf" ]; then echo "Error: CERB_FPM_POOL='${CERB_FPM_POOL}' is not an available pool."; exit 1; fi \
&& if [ -z ${CERB_INSTALL} ]; then rm -Rf /var/www/html/install; fi \
&& rm -f /etc/php/8.5/fpm/pool.d/*.conf \
&& envsubst "\$CERB_WEB_CHILDREN \$CERB_BACKGROUND_CHILDREN" \
  < "/etc/php/8.5/fpm/pools-available/${CERB_FPM_POOL}.conf" \
  > "/etc/php/8.5/fpm/pool.d/${CERB_FPM_POOL}.conf" \
&& php-fpm8.5 -F
