FROM ghcr.io/studyfranco/docker-baseimages-debian:testing

LABEL maintainer="studyfranco@gmail.com"

RUN set -x \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y va-driver-all mesa-utils mesa-va-drivers mesa-vulkan-drivers mesa-opencl-icd libgl1-mesa-dri libglx-mesa0 vulkan-tools vainfo intel-media-va-driver-non-free firmware-intel-graphics firmware-intel-misc intel-opencl-icd --no-install-recommends --fix-missing \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && touch /var/cache/a && touch /var/log/a && touch /var/tmp/a && touch /tmp/a \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -x \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpegthumbs mkvtoolnix ffmpeg mediainfo --no-install-recommends --fix-missing \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && touch /var/cache/a && touch /var/log/a && touch /var/tmp/a && touch /tmp/a \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*