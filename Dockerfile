# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# set version label
ARG BUILD_DATE
ARG VERSION
ARG MAME_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=MAME \
    NO_DECOR=true

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/mame-logo.png && \
  echo "**** install packages ****" && \
  apt-key adv \
    --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv-keys BD90C31EDB703FB5C74D68DBE309D18C36773207 && \
  echo \
    "deb https://ppa.launchpadcontent.net/c.falco/mame/ubuntu  noble main" > \
    /etc/apt/sources.list.d/mame.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends -y \
    mame && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3001

VOLUME /config /mame
