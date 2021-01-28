#!/bin/bash

# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load Phabricator environment
. /opt/bitnami/scripts/phabricator-env.sh

# Load libraries
. /opt/bitnami/scripts/libphabricator.sh
. /opt/bitnami/scripts/libwebserver.sh

# Load web server environment and functions (after Phabricator environment file so MODULE is not set to a wrong value)
. "/opt/bitnami/scripts/$(web_server_type)-env.sh"

DOMAIN="${1:?missing host}"

# Configure host
export PHABRICATOR_HOST="$DOMAIN"
phabricator_configure_host
