FROM ghcr.io/studyfranco/docker-baseimages-debian:stable

LABEL maintainer="studyfranco@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux \
    && echo "deb https://www.deb-multimedia.org stable main non-free" > /etc/apt/sources.list.d/multimedia.list \
    && apt-get update -oAcquire::AllowInsecureRepositories=true \
    && apt-get install -y --allow-unauthenticated deb-multimedia-keyring --no-install-recommends \
    && rm /etc/apt/sources.list.d/multimedia.list \
    && echo "Types: deb deb-src\nURIs: https://www.deb-multimedia.org\nSuites: stable testing unstable\nComponents: main non-free\nEnabled: yes\nSigned-By: /usr/share/keyrings/deb-multimedia-keyring.pgp" > /etc/apt/sources.list.d/multimedia.sources \
    && apt-get autoremove --purge -y \
    && apt-get clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -eux \
    && apt-get update \
    && apt-get install -y clinfo va-driver-all mesa-va-drivers mesa-vulkan-drivers mesa-opencl-icd libgl1-mesa-dri libglx-mesa0 vulkan-tools vainfo intel-media-va-driver-non-free intel-opencl-icd --no-install-recommends \
    && apt-get autoremove --purge -y \
    && apt-get clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -eux \
    && apt-get update \
    && apt-get install -y mkvtoolnix ffmpeg mediainfo --no-install-recommends \
    && apt-get autoremove --purge -y \
    && apt-get clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*