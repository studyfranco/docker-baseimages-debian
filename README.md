# Docker Base Image: Debian Slim with Essential Tools

<div align="center">
  
![Github stars](https://badgen.net/github/stars/studyfranco/docker-baseimages-debian?icon=github&label=stars)
![Github forks](https://badgen.net/github/forks/studyfranco/docker-baseimages-debian?icon=github&label=forks)
![Github issues](https://img.shields.io/github/issues/studyfranco/docker-baseimages-debian)
![Github last-commit](https://img.shields.io/github/last-commit/studyfranco/docker-baseimages-debian)
  
</div>

## Overview

This repository provides a streamlined Docker base image built upon [Debian Slim](https://hub.docker.com/_/debian). It serves as a minimal yet functional foundation for your Docker projects, incorporating essential tools to enhance development efficiency.

## Features

- **Debian Slim Base**: Utilizes the lightweight Debian Slim variant, ensuring a smaller footprint without compromising versatility.

- **Pre-installed Editors**: Includes `nano` and `vi` by default, facilitating immediate text editing capabilities within containers.

## Usage

To build a Docker image using this base image, create a `Dockerfile` as follows:

```Dockerfile
FROM ghcr.io/studyfranco/docker-baseimages-debian:stable
LABEL maintainer="Your.Pseudo <you@pom.com>"

RUN set -x \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y jq python3-full --no-install-recommends --fix-missing \
    && apt dist-upgrade -y \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*
```

Replace `stable` with the desired branch or tag as needed.

## Branches and Tags

- **Stable**: Represents the most reliable and tested version of the base image.

- **Testing**: Contains the latest features and updates that are under evaluation.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your enhancements or fixes.

## Acknowledgements

This project is inspired by and based on the work of [LinuxServer.io's Docker Baseimage Debian](https://github.com/linuxserver/docker-baseimage-debian). We extend our gratitude to the LinuxServer.io team for their contributions to the open-source community.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

---

For more information and updates, visit the [GitHub Repository](https://github.com/studyfranco/docker-baseimages-debian).
