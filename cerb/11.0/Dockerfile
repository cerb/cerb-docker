ARG CERB_BRANCH="v11.0"
ARG CERB_DIR=/var/www/html

FROM cerb/cerb:base-8.3-fpm
ARG CERB_DIR
ARG CERB_BRANCH

VOLUME /mnt/storage

WORKDIR ${CERB_DIR}

# This checks if the latest commit changed, otherwise use build cache
ADD "https://api.github.com/repos/cerb/cerb-release/commits?per_page=1&sha=${CERB_BRANCH}" /tmp/latest_commit

RUN git clone -b ${CERB_BRANCH} --single-branch https://github.com/cerb/cerb-release . \
  && rm -Rf .git .github storage \
  && chown -R www-data:www-data . \
  && chmod 440 $(find ${CERB_DIR} -type f) \
  && chmod 550 $(find ${CERB_DIR} -type d)

COPY --chmod=0500 entry.sh /

# Entry replaces ENV variables with envsubst
COPY cerb/framework.config.template.php /etc/cerb/framework.config.template.php

RUN apt-get -y remove git \
  && apt-get -y autoremove --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "/entry.sh" ]