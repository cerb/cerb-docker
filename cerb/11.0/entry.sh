#!/bin/bash
set -e \
&& chown www-data:www-data /mnt/storage \
&& chmod 0770 /mnt/storage \
&& envsubst "\$CERB_DB_HOST \$CERB_DB_NAME \$CERB_DB_USER \$CERB_DB_PASS \$CERB_AUTHORIZED_IPS \$CERB_PROXY_HOST \$CERB_PROXY_PORT" \
  < /etc/cerb/framework.config.template.php > /var/www/html/framework.config.php \
&& if [ -z ${CERB_DB_HOST} ]; then echo "Error: CERB_DB_HOST is required."; exit 1; fi \
&& if [ -z ${CERB_DB_NAME} ]; then echo "Error: CERB_DB_NAME is required."; exit 1; fi \
&& if [ -z ${CERB_DB_USER} ]; then echo "Error: CERB_DB_USER is required."; exit 1; fi \
&& if [ -z ${CERB_DB_PASS} ]; then echo "Error: CERB_DB_PASS is required."; exit 1; fi \
&& if [ -z ${CERB_INSTALL} ]; then rm -Rf /var/www/html/install; fi \
&& php-fpm