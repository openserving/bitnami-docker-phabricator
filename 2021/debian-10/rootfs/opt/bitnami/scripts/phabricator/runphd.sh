#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/libphabricator.sh

# Load Phabricator environment
. /opt/bitnami/scripts/phabricator-env.sh

# Constants
EXEC="$(command -v phd)"
declare -a args=("start" "$@")

info "** Starting Phabricator daemons **"
if am_i_root; then
    exec gosu "$PHABRICATOR_DAEMON_USER" "${EXEC}" "${args[@]}"
else
    exec "${EXEC}" "${args[@]}"
fi
