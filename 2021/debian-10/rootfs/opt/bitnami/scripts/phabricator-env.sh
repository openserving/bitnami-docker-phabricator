#!/bin/bash
#
# Environment configuration for phabricator

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-phabricator}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
phabricator_env_vars=(
    PHABRICATOR_DATA_DIR
    PHABRICATOR_DATA_TO_PERSIST
    PHABRICATOR_HOST
    PHABRICATOR_EXTERNAL_HTTP_PORT_NUMBER
    PHABRICATOR_EXTERNAL_HTTPS_PORT_NUMBER
    PHABRICATOR_ALTERNATE_FILE_DOMAIN
    PHABRICATOR_USE_LFS
    PHABRICATOR_ENABLE_HTTPS
    PHABRICATOR_ENABLE_PYGMENTS
    PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY
    PHABRICATOR_SSH_PORT_NUMBER
    PHABRICATOR_SKIP_BOOTSTRAP
    PHABRICATOR_USERNAME
    PHABRICATOR_PASSWORD
    PHABRICATOR_EMAIL
    PHABRICATOR_FIRST_NAME
    PHABRICATOR_LAST_NAME
    PHABRICATOR_SMTP_HOST
    PHABRICATOR_SMTP_PORT_NUMBER
    PHABRICATOR_SMTP_USER
    PHABRICATOR_SMTP_PASSWORD
    PHABRICATOR_SMTP_PROTOCOL
    PHABRICATOR_DATABASE_HOST
    PHABRICATOR_DATABASE_PORT_NUMBER
    PHABRICATOR_DATABASE_ADMIN_USER
    PHABRICATOR_DATABASE_ADMIN_PASSWORD
    PHABRICATOR_EXISTING_DATABASE_USER
    PHABRICATOR_EXISTING_DATABASE_PASSWORD
    PHABRICATOR_FIRSTNAME
    PHABRICATOR_LASTNAME
    SMTP_HOST
    SMTP_PORT
    PHABRICATOR_SMTP_PORT
    SMTP_USER
    SMTP_PASSWORD
    SMTP_PROTOCOL
    MARIADB_HOST
    MARIADB_PORT_NUMBER
    MARIADB_USER
    MARIADB_PASSWORD
)
for env_var in "${phabricator_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset phabricator_env_vars

# Paths
export PHABRICATOR_BASE_DIR="${BITNAMI_ROOT_DIR}/phabricator"
export PHABRICATOR_BIN_DIR="${PHABRICATOR_BASE_DIR}/bin"
export PHABRICATOR_VAR_DIR="${PHABRICATOR_BASE_DIR}/var"
export PHABRICATOR_LOGS_DIR="${PHABRICATOR_VAR_DIR}/log"
export PHABRICATOR_CONF_FILE="${PHABRICATOR_BASE_DIR}/conf/local/local.json"
export PHABRICATOR_PID_FILE="${PHABRICATOR_VAR_DIR}/pid/phd.pid"
export PATH="${PHABRICATOR_BIN_DIR}:/opt/bitnami/git/bin:${PATH}"

# Phabricator persistence configuration
export PHABRICATOR_VOLUME_DIR="${BITNAMI_VOLUME_DIR}/phabricator"
export PHABRICATOR_DATA_DIR="${PHABRICATOR_DATA_DIR:-${PHABRICATOR_BASE_DIR}/data}"
export PHABRICATOR_DATA_TO_PERSIST="${PHABRICATOR_DATA_TO_PERSIST:-conf/local/local.json data var/repo}"

# System users (when running with a privileged user)
export PHABRICATOR_DAEMON_USER="phabricator"
export PHABRICATOR_DAEMON_GROUP="phabricator"
export PHABRICATOR_SSH_VCS_USER="git"
export PHABRICATOR_SSH_VCS_GROUP="git"

# Phabricator configuration
export PHABRICATOR_HOST="${PHABRICATOR_HOST:-}" # only used during the first initialization
export PHABRICATOR_EXTERNAL_HTTP_PORT_NUMBER="${PHABRICATOR_EXTERNAL_HTTP_PORT_NUMBER:-80}" # only used during the first initialization
export PHABRICATOR_EXTERNAL_HTTPS_PORT_NUMBER="${PHABRICATOR_EXTERNAL_HTTPS_PORT_NUMBER:-443}" # only used during the first initialization
export PHABRICATOR_ALTERNATE_FILE_DOMAIN="${PHABRICATOR_ALTERNATE_FILE_DOMAIN:-}" # only used during the first initialization
export PHABRICATOR_USE_LFS="${PHABRICATOR_USE_LFS:-no}" # only used during the first initialization
export PHABRICATOR_ENABLE_HTTPS="${PHABRICATOR_ENABLE_HTTPS:-yes}" # only used during the first initialization
export PHABRICATOR_ENABLE_PYGMENTS="${PHABRICATOR_ENABLE_PYGMENTS:-yes}" # only used during the first initialization
export PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY="${PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY:-no}"
export PHABRICATOR_DEFAULT_SSH_PORT_NUMBER="2222" # only used at build time
export PHABRICATOR_SSH_PORT_NUMBER="${PHABRICATOR_SSH_PORT_NUMBER:-}"
export PHABRICATOR_SKIP_BOOTSTRAP="${PHABRICATOR_SKIP_BOOTSTRAP:-}" # only used during the first initialization

# Phabricator credentials
export PHABRICATOR_USERNAME="${PHABRICATOR_USERNAME:-user}" # only used during the first initialization
export PHABRICATOR_PASSWORD="${PHABRICATOR_PASSWORD:-bitnami1}" # only used during the first initialization
export PHABRICATOR_EMAIL="${PHABRICATOR_EMAIL:-user@example.com}" # only used during the first initialization
PHABRICATOR_FIRST_NAME="${PHABRICATOR_FIRST_NAME:-"${PHABRICATOR_FIRSTNAME:-}"}"
export PHABRICATOR_FIRST_NAME="${PHABRICATOR_FIRST_NAME:-FirstName}" # only used during the first initialization
PHABRICATOR_LAST_NAME="${PHABRICATOR_LAST_NAME:-"${PHABRICATOR_LASTNAME:-}"}"
export PHABRICATOR_LAST_NAME="${PHABRICATOR_LAST_NAME:-LastName}" # only used during the first initialization

# Phabricator SMTP credentials
PHABRICATOR_SMTP_HOST="${PHABRICATOR_SMTP_HOST:-"${SMTP_HOST:-}"}"
export PHABRICATOR_SMTP_HOST="${PHABRICATOR_SMTP_HOST:-}" # only used during the first initialization
PHABRICATOR_SMTP_PORT_NUMBER="${PHABRICATOR_SMTP_PORT_NUMBER:-"${SMTP_PORT:-}"}"
PHABRICATOR_SMTP_PORT_NUMBER="${PHABRICATOR_SMTP_PORT_NUMBER:-"${PHABRICATOR_SMTP_PORT:-}"}"
export PHABRICATOR_SMTP_PORT_NUMBER="${PHABRICATOR_SMTP_PORT_NUMBER:-}" # only used during the first initialization
PHABRICATOR_SMTP_USER="${PHABRICATOR_SMTP_USER:-"${SMTP_USER:-}"}"
export PHABRICATOR_SMTP_USER="${PHABRICATOR_SMTP_USER:-}" # only used during the first initialization
PHABRICATOR_SMTP_PASSWORD="${PHABRICATOR_SMTP_PASSWORD:-"${SMTP_PASSWORD:-}"}"
export PHABRICATOR_SMTP_PASSWORD="${PHABRICATOR_SMTP_PASSWORD:-}" # only used during the first initialization
PHABRICATOR_SMTP_PROTOCOL="${PHABRICATOR_SMTP_PROTOCOL:-"${SMTP_PROTOCOL:-}"}"
export PHABRICATOR_SMTP_PROTOCOL="${PHABRICATOR_SMTP_PROTOCOL:-}" # only used during the first initialization

# Database configuration
export PHABRICATOR_DEFAULT_DATABASE_HOST="mariadb" # only used at build time
PHABRICATOR_DATABASE_HOST="${PHABRICATOR_DATABASE_HOST:-"${MARIADB_HOST:-}"}"
export PHABRICATOR_DATABASE_HOST="${PHABRICATOR_DATABASE_HOST:-$PHABRICATOR_DEFAULT_DATABASE_HOST}" # only used during the first initialization
PHABRICATOR_DATABASE_PORT_NUMBER="${PHABRICATOR_DATABASE_PORT_NUMBER:-"${MARIADB_PORT_NUMBER:-}"}"
export PHABRICATOR_DATABASE_PORT_NUMBER="${PHABRICATOR_DATABASE_PORT_NUMBER:-3306}" # only used during the first initialization
PHABRICATOR_DATABASE_ADMIN_USER="${PHABRICATOR_DATABASE_ADMIN_USER:-"${MARIADB_USER:-}"}"
export PHABRICATOR_DATABASE_ADMIN_USER="${PHABRICATOR_DATABASE_ADMIN_USER:-root}" # only used during the first initialization
PHABRICATOR_DATABASE_ADMIN_PASSWORD="${PHABRICATOR_DATABASE_ADMIN_PASSWORD:-"${MARIADB_PASSWORD:-}"}"
export PHABRICATOR_DATABASE_ADMIN_PASSWORD="${PHABRICATOR_DATABASE_ADMIN_PASSWORD:-}" # only used during the first initialization
export PHABRICATOR_EXISTING_DATABASE_USER="${PHABRICATOR_EXISTING_DATABASE_USER:-}" # only used during the first initialization
export PHABRICATOR_EXISTING_DATABASE_PASSWORD="${PHABRICATOR_EXISTING_DATABASE_PASSWORD:-}" # only used during the first initialization

# PHP configuration
export PHP_DEFAULT_MEMORY_LIMIT="256M" # only used at build time

# Custom environment variables may be defined below
