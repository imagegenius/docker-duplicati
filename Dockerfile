FROM vcxpz/baseimage-mono

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Fork of Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Alex Hyde"

# environment settings
ARG DUPLICATI_URL
ENV HOME="/config"

RUN \
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
   rm -rf \
      /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8200
VOLUME /backups /config /source
