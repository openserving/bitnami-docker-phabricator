FROM bitnami/oraclelinux-extras:7-r468
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
RUN install_packages bzip2-libs cyrus-sasl-lib expat freetds-libs freetype glibc gmp gnutls keyutils-libs krb5-libs libcom_err libcurl libffi libgcc libgcrypt libgpg-error libicu libidn libjpeg-turbo libmemcached libnghttp2 libpng libselinux libssh2 libstdc++ libtasn1 libtidy libxml2 libxslt ncurses-libs nettle nspr nss nss-softokn-freebl nss-util openldap openssh-server openssl-libs p11-kit pcre postgresql-libs python-pygments readline sqlite xz-libs zlib
RUN bitnami-pkg unpack apache-2.4.41-1 --checksum 64b7880c3d0f0f9e7cde0e71496eed06d4240a90a2b6d62c2443fce54c614691
RUN bitnami-pkg unpack php-7.3.9-1 --checksum d12b49a00eb74dae3b46b4c5b57c9709e79e3157ddd26959c8ca08e919265bb7
RUN bitnami-pkg install mysql-client-10.3.18-1 --checksum d591461ce65ca7c65ebdaf443a4dad68c05e5153cf2d5a9a97b2ff1171dfe42e
RUN bitnami-pkg install libphp-7.3.9-0 --checksum d571181cffcf99e28bf1a53f5664136b391f99996f1471ab426aa73e6f09eed2
RUN bitnami-pkg install git-2.23.0-0 --checksum 30618c63e72727b90b3cc3e7f8747e599ec11352b29812285a27029807d8766d
RUN bitnami-pkg unpack phabricator-2019.37.0-0 --checksum 9dc51807ff19eba3e9b0398aeea48706e6224ebddedddcb58f9dff3fdab39675
RUN ln -sf /dev/stdout /opt/bitnami/apache/logs/access_log
RUN ln -sf /dev/stderr /opt/bitnami/apache/logs/error_log

COPY rootfs /
ENV APACHE_HTTPS_PORT_NUMBER="" \
    APACHE_HTTP_PORT_NUMBER="" \
    APACHE_SET_HTTPS_PORT="no" \
    APACHE_SET_HTTP_PORT="no" \
    BITNAMI_APP_NAME="phabricator" \
    BITNAMI_IMAGE_VERSION="2019.37.0-ol-7-r3" \
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

VOLUME [ "/certs" ]

EXPOSE 80 443

ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "/run.sh" ]
