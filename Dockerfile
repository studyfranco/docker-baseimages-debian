FROM curlimages/curl:latest AS cert-provider

FROM debian:stable-slim

LABEL maintainer="studyfranco@gmail.com"

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=cert-provider /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

RUN set -eux \
    && mkdir -p /usr/lib/ssl \
    && ln -sf /etc/ssl/certs/ca-certificates.crt /usr/lib/ssl/cert.pem \
    && echo 'Acquire::https::CaInfo "/etc/ssl/certs/ca-certificates.crt";' > /etc/apt/apt.conf.d/99cainfo \
    && echo "Acquire::Languages { \"fr\"; \"de\"; \"ru\"; \"en\"; \"none\";};" > /etc/apt/apt.conf.d/docker-no-languages \
    && echo "" > /etc/apt/sources.list \
    && echo "Types: deb deb-src\nURIs: https://deb.debian.org/debian\nSuites: stable testing unstable\nComponents: main contrib non-free non-free-firmware\nEnabled: yes\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" > /etc/apt/sources.list.d/debian.sources \
    && echo "Package: *\nPin: release a=stable\nPin-Priority: 510" > /etc/apt/preferences.d/list \
    && echo "Package: *\nPin: release a=testing\nPin-Priority: 495" >> /etc/apt/preferences.d/list \
    && echo "Package: *\nPin: release a=unstable\nPin-Priority: 490" >> /etc/apt/preferences.d/list \
    && apt-get update \
    && apt-get install -y ca-certificates --no-install-recommends \
    && rm -f /etc/apt/apt.conf.d/99cainfo \
    && apt-get purge -y sudo || true \
    && apt-get dist-upgrade -y \
    && apt-get autoremove --purge -y \
    && apt-get clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -eux \
    && apt-get update \
    && apt-get install -y locales nano vim less tar wget curl pigz sed unzip iproute2 iputils-ping dnsutils bash-completion procps htop \
    && apt-get autoremove --purge -y \
    && apt-get clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*