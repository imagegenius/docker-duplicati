FROM vcxpz/baseimage-alpine-mono:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Duplicati version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ENV HOME="/config"

RUN \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl \
      jq && \
   echo "**** install duplicati ****" && \
   mkdir -p \
      /app/duplicati && \
   curl --silent -o \
      /tmp/duplicati.zip -L \
      "$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/${VERSION} \
         | jq -r '.assets[].browser_download_url' | grep zip | grep -v signatures)" && \
   unzip -q \
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
