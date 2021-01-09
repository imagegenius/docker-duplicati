FROM vcxpz/baseimage-alpine-mono

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Duplicati version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ENV HOME="/config"

RUN set -x && \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl && \
   echo "**** install duplicati ****" && \
   mkdir -p \
      /app/duplicati && \
   curl -o \
      /tmp/duplicati.zip -L \
      "https://github.com/duplicati/duplicati/releases/download/${VERSION}/duplicati-${VERSION//v[0-9].[0-9].[0-9].[0-9]-}.zip" && \
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
VOLUME /backups /config /source
