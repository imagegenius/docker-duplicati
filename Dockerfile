FROM vcxpz/baseimage-mono

# set version label
ARG BUILD_DATE
ARG DUPLICATI_RELEASE
LABEL build_version="Duplicati version:- ${DUPLICATI_RELEASE} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Alex Hyde"

# environment settings
ARG DUPLICATI_URL
ENV HOME="/config"

RUN \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl && \
   echo "**** install duplicati ****" && \
   mkdir -p \
      /app/duplicati && \
   curl -o \
   /tmp/duplicati.zip -L \
      "${DUPLICATI_URL}" && \
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
VOLUME /backups /config /source
