FROM docker.io/bitnami/minideb:buster
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV PATH="/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/apache/bin:/opt/bitnami/mysql/bin:/opt/bitnami/git/bin:/opt/bitnami/common/bin:/opt/bitnami/arcanist/bin:/opt/bitnami/phabricator/bin:/opt/bitnami/nami/bin:$PATH"

COPY prebuildfs /
# Install required system packages and dependencies
RUN install_packages ca-certificates curl gzip libargon2-1 libaudit1 libbsd0 libbz2-1.0 libc6 libcap-ng0 libcom-err2 libcurl4 libexpat1 libffi6 libfftw3-double3 libfontconfig1 libfreetype6 libgcc1 libgcrypt20 libglib2.0-0 libgmp10 libgnutls30 libgomp1 libgpg-error0 libgssapi-krb5-2 libhogweed4 libicu63 libidn2-0 libjemalloc2 libjpeg62-turbo libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 liblcms2-2 libldap-2.4-2 liblqr-1-0 libltdl7 liblzma5 libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmcrypt4 libmemcached11 libmemcachedutil2 libncurses6 libnettle6 libnghttp2-14 libp11-kit0 libpam0g libpcre3 libpng16-16 libpq5 libpsl5 libreadline7 librtmp1 libsasl2-2 libsqlite3-0 libssh2-1 libssl1.1 libstdc++6 libsybdb5 libtasn1-6 libtidy5deb1 libtinfo6 libunistring2 libuuid1 libx11-6 libxau6 libxcb1 libxdmcp6 libxext6 libxml2 libxslt1.1 libzip4 ncurses-bin openssh-client openssh-server procps python-pygments python3-pkg-resources python3-pygments sudo tar zlib1g
RUN /build/bitnami-user.sh
RUN /build/install-nami.sh
RUN bitnami-pkg unpack php-7.3.26-1 --checksum 0285f8e8bcc664b2d75c93a89a5d13116978823bb40b2338727b3186e44b2342
RUN bitnami-pkg unpack apache-2.4.46-4 --checksum 35f10bccc2a1e55c050c9c483e28ee729e11f873acadd327d7361b53938a0101
RUN bitnami-pkg install mysql-client-10.3.27-0 --checksum f96905e763a6334b75a7cdb07f8d89658cde02be41cb09d91d0682fc649fdcff
RUN bitnami-pkg install libphp-7.3.26-0 --checksum 2011a6ddd6853afd60b0399ff5c334f7b6b131f90c0e326115d28a06de6b262b
RUN bitnami-pkg install git-2.30.0-0 --checksum da1ad2f9c18b54f8b382df278b29da9b2c870aae3a16783a740b0d9d28c5e0fb
RUN bitnami-pkg install tini-0.19.0-1 --checksum 9b1f1c095944bac88a62c1b63f3bff1bb123aa7ccd371c908c0e5b41cec2528d
RUN bitnami-pkg unpack phabricator-2020.42.0-0 --checksum abd028b224607cc4d3ddb7c15a6616f3e312fd4bb9f6cf88ff7d1e1177815caf
RUN bitnami-pkg install gosu-1.12.0-2 --checksum 4d858ac600c38af8de454c27b7f65c0074ec3069880cb16d259a6e40a46bbc50
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN ln -sf /dev/stdout /opt/bitnami/apache/logs/access_log && \
    ln -sf /dev/stderr /opt/bitnami/apache/logs/error_log

COPY rootfs /
RUN ln -s /opt/bitnami/php/bin/php /usr/local/bin/php && \
    ln -s /opt/bitnami/php/bin/php /usr/bin/php
ENV APACHE_ENABLE_CUSTOM_PORTS="no" \
    APACHE_HTTPS_PORT_NUMBER="443" \
    APACHE_HTTP_PORT_NUMBER="80" \
    BITNAMI_APP_NAME="phabricator" \
    BITNAMI_IMAGE_VERSION="2020.42.0-debian-10-r82" \
    MARIADB_HOST="mariadb" \
    MARIADB_PASSWORD="" \
    MARIADB_PORT_NUMBER="3306" \
    MARIADB_USER="root" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux" \
    PHABRICATOR_ALTERNATE_FILE_DOMAIN="" \
    PHABRICATOR_EMAIL="user@example.com" \
    PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY="no" \
    PHABRICATOR_FIRSTNAME="FirstName" \
    PHABRICATOR_HOST="127.0.0.1" \
    PHABRICATOR_LASTNAME="LastName" \
    PHABRICATOR_PASSWORD="bitnami1" \
    PHABRICATOR_SSH_PORT_NUMBER="22" \
    PHABRICATOR_SSH_VCS_GROUP="git" \
    PHABRICATOR_SSH_VCS_USER="git" \
    PHABRICATOR_USERNAME="user" \
    PHABRICATOR_USE_LFS="no" \
    PHP_MEMORY_LIMIT="256M" \
    SMTP_HOST="" \
    SMTP_PASSWORD="" \
    SMTP_PORT="" \
    SMTP_PROTOCOL="" \
    SMTP_USER=""

EXPOSE 80 443

ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "/run.sh" ]
