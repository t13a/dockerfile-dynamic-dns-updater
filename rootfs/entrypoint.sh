#!/bin/sh

set -euo pipefail

CRONTAB="/var/spool/cron/crontabs/${UPDATER_USER}"
PARAMS=/params

addgroup -g "${UPDATER_GID}" "${UPDATER_USER}"
adduser -h /dev/null -s /sbin/nologin -G "${UPDATER_USER}" -DH -u "${UPDATER_UID}" "${UPDATER_USER}"

if [ ! -e "${CRONTAB:-}" ]
then
    echo "${UPDATER_SCHEDULE} cat ${PARAMS} | xargs ${UPDATER_PY}" > "${CRONTAB}"
fi

if [ ! -e "${PARAMS:-}" ]
then
    touch "${PARAMS}"
    chown "${UPDATER_USER}:${UPDATER_USER}" "${PARAMS}"
    chmod 600 "${PARAMS}"
    echo "-u ${USERNAME} -p ${PASSWORD} ${DOMAIN} ${SUB_DOMAIN} ${CPANEL_URL}" > "${PARAMS}"
fi

if [ ${#@} -gt 0 ]
then
    exec "${@}"
elif [ -n "${DISABLE_CROND:-}" ]
then
    cat "${PARAMS}" | xargs "${UPDATER_PY}"
else
    exec crond -f
fi
