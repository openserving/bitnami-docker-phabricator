#!/bin/bash

# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load Phabricator environment
. /opt/bitnami/scripts/phabricator-env.sh

# Load PHP environment for 'php_conf_set' (after 'phabricator-env.sh' so that MODULE is not set to a wrong value)
. /opt/bitnami/scripts/php-env.sh

# Load libraries
. /opt/bitnami/scripts/libphabricator.sh
. /opt/bitnami/scripts/libfile.sh
. /opt/bitnami/scripts/libfs.sh
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libphp.sh
. /opt/bitnami/scripts/libwebserver.sh

# Load web server environment and functions (after Phabricator environment file so MODULE is not set to a wrong value)
. "/opt/bitnami/scripts/$(web_server_type)-env.sh"

# Configure required PHP options for application to work properly, based on build-time defaults
info "Configuring default PHP options for Phabricator"
php_conf_set memory_limit "$PHP_DEFAULT_MEMORY_LIMIT"
php_conf_set always_populate_raw_post_data "-1" # see https://secure.phabricator.com/D16454
php_conf_set opcache.validate_timestamps "0" # see https://secure.phabricator.com/T11746
php_conf_set extension "apcu.so" # see https://github.com/bitnami/bitnami-docker-phabricator/issues/78

# Enable default web server configuration for Phabricator
info "Creating default web server configuration for Phabricator"
web_server_validate

# shellcheck disable=SC2016
ensure_web_server_app_configuration_exists "phabricator" --type php --document-root "${PHABRICATOR_BASE_DIR}/webroot" --apache-extra-directory-configuration '
DirectoryIndex index.html index.php
RewriteEngine on
RewriteRule   ^/rsrc/(.*)     -                       [L,QSA]
RewriteRule   ^/favicon.ico   -                       [L,QSA]
RewriteCond   %{QUERY_STRING} ^.*__path__.*$          [NC]
RewriteRule   .*              -                       [L,NC,QSA]
RewriteRule   ^(.*)$          /index.php?__path__=/$1 [B,L,QSA]
'

# Ensure required directories exists
mkdir -p "$PHABRICATOR_VOLUME_DIR" "${PHABRICATOR_DATA_DIR}" "${PHABRICATOR_VAR_DIR}/"{log,pid,repo,tmp}
for dir in "${PHABRICATOR_BASE_DIR}/conf/local" "$PHABRICATOR_VOLUME_DIR" "${PHABRICATOR_DATA_DIR}" "${PHABRICATOR_VAR_DIR}"; do
    configure_permissions_ownership "$dir" -d "775" -f "664"
done
chmod g+rwX "$PHABRICATOR_BASE_DIR"

ln -sf "/dev/stdout" "${APACHE_LOGS_DIR}/access_log"
ln -sf "/dev/stderr" "${APACHE_LOGS_DIR}/error_log"
