FROM alpine AS builder

ARG UPDATER_BRANCH=master
ARG UPDATER_REPOSITORY=https://github.com/swyngaard/dynamic-dns-updater

RUN apk add --no-cache git && \
    git clone -b "${UPDATER_BRANCH}" "${UPDATER_REPOSITORY}" /dynamic-dns-updater

FROM python:alpine

COPY --from=builder /dynamic-dns-updater /dynamic-dns-updater
COPY /rootfs /

RUN apk add --no-cache su-exec && \
    pip install requests

ENV UPDATER_PY=/dynamic-dns-updater/updater.py \
    UPDATER_USER=updater \
    UPDATER_UID=1000 \
    UPDATER_GID=1000 \
    UPDATER_SCHEDULE='0,15,30,45 * * * *'

ENTRYPOINT [ "/entrypoint.sh" ]
