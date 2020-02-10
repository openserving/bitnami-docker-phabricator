FROM bitnami/minideb:buster
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV PATH="/opt/bitnami/apache/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/mysql/bin:/opt/bitnami/git/bin:/opt/bitnami/arcanist/bin:/opt/bitnami/phabricator/bin:/opt/bitnami/nami/bin:$PATH"

COPY prebuildfs /
# Install required system packages and dependencies
RUN install_packages ca-certificates curl dirmngr gnupg libbz2-1.0 libc6 libcom-err2 libcurl4 libexpat1 libffi6 libfreetype6 libgcc1 libgcrypt20 libgmp10 libgnutls30 libgpg-error0 libgssapi-krb5-2 libhogweed4 libicu63 libidn2-0 libjpeg62-turbo libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libldap-2.4-2 liblzma5 libmemcached11 libmemcachedutil2 libncurses6 libnettle6 libnghttp2-14 libp11-kit0 libpcre3 libpng16-16 libpq5 libpsl5 libreadline7 librtmp1 libsasl2-2 libsqlite3-0 libssh2-1 libssl1.1 libstdc++6 libsybdb5 libtasn1-6 libtidy5deb1 libtinfo6 libunistring2 libxml2 libxslt1.1 libzip4 openssh-client openssh-server procps python-pygments python3-pkg-resources python3-pygments sudo unzip zlib1g
RUN /build/bitnami-user.sh && \
    /build/install-nami.sh
RUN bitnami-pkg unpack apache-2.4.41-0 --checksum 0364e80e08a89fda2d2d302609f813d5d497b6cb6bcf6643d2770b825abbc0fb
RUN bitnami-pkg unpack php-7.3.14-0 --checksum 58ea3eac602c9e840afb1cde192bda1018c62e3485c41962bc0266b079dd731f
RUN bitnami-pkg install mysql-client-10.3.22-0 --checksum 9529ac5187264223e3852602f7d9a51ed0b2547bbed99f3d05f3b7fa20adf57f
RUN bitnami-pkg install libphp-7.3.14-0 --checksum b9d1872eeaf47fe678aaefd4d5925be1bbab64d67f808c14d849039a204faad8
RUN bitnami-pkg install git-2.25.0-0 --checksum 392bea1a8c3607f8ebce5403ec22819915ab8a5cc2245a5249568660b4ed07df
RUN bitnami-pkg unpack phabricator-2020.5.0-0 --checksum c4946ead047adc36cd38d913e5f6d7d5aa6e09fa2137183a557f458f40efba50
RUN apt-get update && apt-get upgrade && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN /build/install-gosu.sh
RUN /build/install-tini.sh

COPY rootfs /
RUN ln -s /opt/bitnami/php/bin/php /usr/local/bin/php
ENV APACHE_HTTPS_PORT_NUMBER="" \
    APACHE_HTTP_PORT_NUMBER="" \
    APACHE_SET_HTTPS_PORT="no" \
    APACHE_SET_HTTP_PORT="no" \
    BITNAMI_APP_NAME="phabricator" \
    BITNAMI_IMAGE_VERSION="2020.5.0-debian-10-r2" \
    MARIADB_HOST="mariadb" \
    MARIADB_PASSWORD="" \
    MARIADB_PORT_NUMBER="3306" \
    MARIADB_USER="root" \
    PHABRICATOR_ALTERNATE_FILE_DOMAIN="" \
    PHABRICATOR_EMAIL="user@example.com" \
    PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY="no" \
    PHABRICATOR_FIRSTNAME="FirstName" \
    PHABRICATOR_HOST="127.0.0.1" \
    PHABRICATOR_LASTNAME="LastName" \
    PHABRICATOR_PASSWORD="bitnami1" \
    PHABRICATOR_SSH_PORT_NUMBER="22" \
    PHABRICATOR_USERNAME="user" \
    PHABRICATOR_USE_LFS="no" \
    SMTP_HOST="" \
    SMTP_PASSWORD="" \
    SMTP_PORT="" \
    SMTP_PROTOCOL="" \
    SMTP_USER=""

EXPOSE 80 443

ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "/run.sh" ]
