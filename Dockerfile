# syntax=docker/dockerfile:1

FROM ghcr.io/imagegenius/baseimage-alpine:3.17

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DUPLICATI_RELEASE
LABEL build_version="ImageGenius Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydazz"

# environment settings
ENV HOME="/config"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ca-certificates-mono \
    libgdiplus \
    mono-reference-assemblies-facades \
    rclone \
    sqlite-libs \
    terminus-font && \
  echo "**** install duplicati ****" && \
  mkdir -p /app/duplicati && \
  if [ -z ${DUPLICATI_RELEASE} ]; then \
    DUPLICATI_RELEASE=$(curl -sL "https://api.github.com/repos/duplicati/duplicati/releases" | \
      jq -r 'first(.[] | select(.tag_name | contains("beta"))) | .tag_name'); \
  fi && \
  curl -o \
    /tmp/duplicati.zip -L \
    "$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/${DUPLICATI_RELEASE} | \
      jq -r '.assets[].browser_download_url' | grep '.zip$' | grep -v signatures)" && \
  unzip \
    /tmp/duplicati.zip -d \
    /app/duplicati && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8200
VOLUME /config /source /backups
