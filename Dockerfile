FROM vcxpz/baseimage-alpine-mono:latest

# set version label
ARG BUILD_DATE
ARG DUPLICATI_RELEASE
LABEL build_version="Duplicati version:- ${DUPLICATI_RELEASE} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ENV HOME="/config"

RUN set -xe && \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl \
      jq && \
   echo "**** install duplicati ****" && \
   mkdir -p \
      /app/duplicati && \
   curl -o \
      /tmp/duplicati.zip -L \
      "$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/${DUPLICATI_RELEASE} \
         | jq -r '.assets[].browser_download_url' | grep zip | grep -v signatures)" && \
   unzip \
      /tmp/duplicati.zip -d \
      /app/duplicati && \
   echo "**** cleanup ****" && \
   apk del --purge \
      build-dependencies && \
   rm -rf \
      /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8200
VOLUME /config /source
