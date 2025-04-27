FROM debian:testing-slim

LABEL maintainer="studyfranco@gmail.com"

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN set -x \
    && rm /etc/apt/sources.list.d/debian.sources \
    && echo "Acquire::Languages { \"fr\"; \"de\"; \"ru\"; \"en\"; \"none\";};" > /etc/apt/apt.conf.d/docker-no-languages \
    && echo "deb http://deb.debian.org/debian/ testing main contrib non-free non-free-firmware" > /etc/apt/sources.list \
    && apt update \
    && apt install -y ca-certificates apt-transport-https --no-install-recommends \
    && echo "" > /etc/apt/sources.list \
    && echo "Types: deb\nURIs: https://deb.debian.org/debian\nSuites: stable testing unstable\nComponents: main contrib non-free non-free-firmware\nEnabled: yes\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" > /etc/apt/sources.list.d/debian.sources \
    && echo "Package: *\nPin: release a=unstable\nPin-Priority: 490" > /etc/apt/preferences.d/list \
    && echo "Package: *\nPin: release a=stable\nPin-Priority: 480" >> /etc/apt/preferences.d/list \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales nano vim less tar wget curl pigz acl sed unzip gosu net-tools bash-completion htop \
    && DEBIAN_FRONTEND=noninteractive apt purge -yy sudo \
    && echo "C.UTF-8" >> /etc/locale.gen \
    && echo "LANG=C.UTF-8\nLC_MESSAGES=C.UTF-8\nLANGUAGE=" > /etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && locale-gen \
    && apt dist-upgrade -y \
    && apt autopurge -yy \
    && apt clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -x \
    && echo "deb https://www.deb-multimedia.org testing main non-free" > /etc/apt/sources.list.d/multimedia.list \
    && apt-get update -oAcquire::AllowInsecureRepositories=true \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated deb-multimedia-keyring --no-install-recommends \
    && rm /etc/apt/sources.list.d/multimedia.list \
    && echo "Types: deb\nURIs: https://www.deb-multimedia.org\nSuites: stable testing unstable\nComponents: main non-free\nEnabled: yes\nSigned-By: /usr/share/keyrings/deb-multimedia-keyring.pgp" > /etc/apt/sources.list.d/multimedia.sources \
    && apt autopurge -yy \
    && apt clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*