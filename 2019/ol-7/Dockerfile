FROM bitnami/oraclelinux-extras:7-r475
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
RUN install_packages bzip2-libs cyrus-sasl-lib expat freetds-libs freetype glibc gmp gnutls keyutils-libs krb5-libs libcom_err libcurl libffi libgcc libgcrypt libgpg-error libicu libidn libjpeg-turbo libmemcached libnghttp2 libpng libselinux libssh2 libstdc++ libtasn1 libtidy libxml2 libxslt ncurses-libs nettle nspr nss nss-softokn-freebl nss-util openldap openssh-server openssl-libs p11-kit pcre postgresql-libs python-pygments readline sqlite xz-libs zlib
RUN bitnami-pkg unpack apache-2.4.41-2 --checksum bf50a12c033c1ff0e1cb7696cc1abd29a132cc1c5225e9d2fdbb3c6584e349fe
RUN bitnami-pkg unpack php-7.3.9-2 --checksum 5c1255ac466225ad8a68d970ee6f6e2e246d39e01aeab455557ea267bd55160a
RUN bitnami-pkg install mysql-client-10.3.18-2 --checksum c9d987cf8f6f6831d04920d64598d0c77cf994235753cf4d5d18ac787c12918e
RUN bitnami-pkg install libphp-7.3.9-0 --checksum d571181cffcf99e28bf1a53f5664136b391f99996f1471ab426aa73e6f09eed2
RUN bitnami-pkg install git-2.23.0-1 --checksum a145f72a986e09dbdb13ce0d1ccbaf2bb78c8571610f4d3d61b8d97abab0c342
RUN bitnami-pkg unpack phabricator-2019.37.0-1 --checksum a10541b8142fac45cfbab530c69a269583540ca8317e2df864f092d143d79129

COPY rootfs /
ENV BITNAMI_APP_NAME="phabricator" \
    BITNAMI_IMAGE_VERSION="2019.37.0-ol-7-r11" \
    MARIADB_HOST="mariadb" \
    MARIADB_PASSWORD="" \
    MARIADB_PORT_NUMBER="3306" \
    MARIADB_USER="root" \
    PATH="/opt/bitnami/apache/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/mysql/bin:/opt/bitnami/git/bin:/opt/bitnami/arcanist/bin:/opt/bitnami/phabricator/bin:$PATH" \
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
