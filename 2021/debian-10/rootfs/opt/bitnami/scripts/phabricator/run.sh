#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load Phabricator environment
. /opt/bitnami/scripts/phabricator-env.sh

# Load libraries
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libservice.sh
. /opt/bitnami/scripts/libwebserver.sh

# Catch SIGTERM signal and stop all child processes
_forwardTerm() {
    warn "Caught signal SIGTERM, passing it to child processes..."
    pgrep -P $$ | xargs kill -TERM 2>/dev/null
    wait
    exit $?
}
trap _forwardTerm TERM

if am_i_root && is_boolean_yes "$PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY"; then
    info "** Starting SSHD **"
    if command -v systemctl &> /dev/null; then
        systemctl start sshd.service
    else
        service ssh start
    fi
else
    is_boolean_yes "$PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY" && warn "SSHD will not be started because of running as a non-root user"
fi

# Start Phabricator daemons
/opt/bitnami/scripts/phabricator/runphd.sh

# Start Apache
exec "/opt/bitnami/scripts/$(web_server_type)/run.sh"
