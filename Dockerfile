FROM debian:testing-slim

LABEL maintainer="studyfranco@gmail.com"

RUN set -x \
    && rm /etc/apt/sources.list.d/debian.sources \
    && echo "Acquire::Languages { \"fr\"; \"de\"; \"ru\"; \"en\";};" > /etc/apt/apt.conf.d/docker-no-languages \
    && echo "deb http://deb.debian.org/debian/ testing main contrib non-free non-free-firmware" > /etc/apt/sources.list \
    && apt update \
    && apt install -y ca-certificates apt-transport-https --no-install-recommends \
    && echo "" > /etc/apt/sources.list \
    && echo "Types: deb\nURIs: https://deb.debian.org/debian\nSuites: testing\nComponents: main contrib non-free non-free-firmware\nEnabled: yes\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" > /etc/apt/sources.list.d/debian.sources \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && echo "C.UTF-8 UTF-8\nde_DE.UTF-8 UTF-8\nen_GB.UTF-8 UTF-8\nen_US.UTF-8 UTF-8\nfr_FR.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8\nLC_MESSAGES=en_US.UTF-8\nLANGUAGE=" > /etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && locale-gen \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nano vi less tar wget curl pigz acl sed unzip gosu \
    && DEBIAN_FRONTEND=noninteractive apt purge -yy sudo \
    && apt dist-upgrade -y \
    && echo "\nTypes: deb\nURIs: https://deb.debian.org/debian\nSuites: unstable\nComponents: main contrib non-free non-free-firmware\nEnabled: yes\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" >> /etc/apt/sources.list.d/debian.sources \
    && echo "\nTypes: deb\nURIs: https://deb.debian.org/debian\nSuites: stable\nComponents: main contrib non-free non-free-firmware\nEnabled: yes\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" >> /etc/apt/sources.list.d/debian.sources \
    && echo "Package: *\nPin: release a=unstable\nPin-Priority: 490" > /etc/apt/preferences.d/list \
    && echo "Package: *\nPin: release a=stable\nPin-Priority: 480" >> /etc/apt/preferences.d/list \
    && apt autopurge -yy \
    && apt clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -x \
    && echo "deb https://www.deb-multimedia.org testing main non-free" > /etc/apt/sources.list.d/multimedia.list \
    && apt-get update -oAcquire::AllowInsecureRepositories=true \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated deb-multimedia-keyring --no-install-recommends \
    && rm /etc/apt/sources.list.d/multimedia.list \
    && echo "Types: deb\nURIs: https://www.deb-multimedia.org\nSuites: testing\nComponents: main non-free\nEnabled: yes\nSigned-By: /usr/share/keyrings/deb-multimedia-keyring.pgp" > /etc/apt/sources.list.d/multimedia.sources \
    && echo "\nTypes: deb\nURIs: https://www.deb-multimedia.org\nSuites: stable\nComponents: main non-free\nEnabled: yes\nSigned-By: /usr/share/keyrings/deb-multimedia-keyring.pgp" >> /etc/apt/sources.list.d/multimedia.sources \
    && echo "\nTypes: deb\nURIs: https://www.deb-multimedia.org\nSuites: unstable\nComponents: main non-free\nEnabled: yes\nSigned-By: /usr/share/keyrings/deb-multimedia-keyring.pgp" >> /etc/apt/sources.list.d/multimedia.sources \
    && apt autopurge -yy \
    && apt clean \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*