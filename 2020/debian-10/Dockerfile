FROM docker.io/bitnami/minideb:buster
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV PATH="/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/apache/bin:/opt/bitnami/mysql/bin:/opt/bitnami/git/bin:/opt/bitnami/common/bin:/opt/bitnami/arcanist/bin:/opt/bitnami/phabricator/bin:/opt/bitnami/nami/bin:$PATH"

COPY prebuildfs /
# Install required system packages and dependencies
RUN install_packages ca-certificates curl gzip libaudit1 libbsd0 libbz2-1.0 libc6 libcap-ng0 libcom-err2 libcurl4 libexpat1 libffi6 libfftw3-double3 libfontconfig1 libfreetype6 libgcc1 libgcrypt20 libglib2.0-0 libgmp10 libgnutls30 libgomp1 libgpg-error0 libgssapi-krb5-2 libhogweed4 libicu63 libidn2-0 libjemalloc2 libjpeg62-turbo libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 liblcms2-2 libldap-2.4-2 liblqr-1-0 libltdl7 liblzma5 libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmcrypt4 libmemcached11 libmemcachedutil2 libncurses6 libnettle6 libnghttp2-14 libp11-kit0 libpam0g libpcre3 libpng16-16 libpq5 libpsl5 libreadline7 librtmp1 libsasl2-2 libsqlite3-0 libssh2-1 libssl1.1 libstdc++6 libsybdb5 libtasn1-6 libtidy5deb1 libtinfo6 libunistring2 libuuid1 libx11-6 libxau6 libxcb1 libxdmcp6 libxext6 libxml2 libxslt1.1 libzip4 openssh-client openssh-server procps python-pygments python3-pkg-resources python3-pygments sudo tar zlib1g
RUN /build/bitnami-user.sh
RUN /build/install-nami.sh
RUN bitnami-pkg unpack php-7.3.19-2 --checksum 25bba77655b298c62ab474954837acbc167a4bcc8555c39b419644c999207c5f
RUN bitnami-pkg unpack apache-2.4.43-5 --checksum e9faded57e3703fe9fcea650eb302e673d969a399fe9dfafa67e173465637665
RUN bitnami-pkg install mysql-client-10.3.23-1 --checksum efab843077267af6a8cde53440a1fef0acf8cb67ab1dcd0b6da2e9cbe050c7e1
RUN bitnami-pkg install libphp-7.3.19-0 --checksum 9d3e785b7544f374e4943f94795625e9048a89fab109ada62552c5784c68bbbe
RUN bitnami-pkg install git-2.27.0-1 --checksum 8d31650a86d07490247771e216e064819564452a7e2c2fe69ffbffdb9c079b0a
RUN bitnami-pkg install tini-0.19.0-0 --checksum 9a8ae20be31a518f042fcec359f2cf35bfdb4e2a56f2fa8ff9ef2ecaf45da80c
RUN bitnami-pkg unpack phabricator-2020.22.0-0 --checksum 8d3c6643f9e84f1a26ea38c0695b08b39b959a0aa7688aaa741b3876665c240d
RUN bitnami-pkg install gosu-1.12.0-1 --checksum 51cfb1b7fd7b05b8abd1df0278c698103a9b1a4964bdacd87ca1d5c01631d59c
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN ln -sf /dev/stdout /opt/bitnami/apache/logs/access_log && \
    ln -sf /dev/stderr /opt/bitnami/apache/logs/error_log

COPY rootfs /
RUN ln -s /opt/bitnami/php/bin/php /usr/local/bin/php
ENV APACHE_ENABLE_CUSTOM_PORTS="no" \
    APACHE_HTTPS_PORT_NUMBER="443" \
    APACHE_HTTP_PORT_NUMBER="80" \
    BITNAMI_APP_NAME="phabricator" \
    BITNAMI_IMAGE_VERSION="2020.22.0-debian-10-r18" \
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
