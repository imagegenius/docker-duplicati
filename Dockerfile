FROM vcxpz/baseimage-alpine-mono:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Duplicati version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ENV HOME="/config"

RUN set -xe && \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies \
		curl \
		jq && \
	echo "**** install duplicati ****" && \
	if [ -z ${VERSION+x} ]; then \
		VERSION=$(curl -sL "https://api.github.com/repos/duplicati/duplicati/releases" | \
			jq -r 'first(.[] | select(.tag_name | contains("beta"))) | .tag_name'); \
	fi && \
	mkdir -p \
		/app/duplicati && \
	curl -o \
		/tmp/duplicati.zip -L \
		"$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/${VERSION} | \
			jq -r '.assets[].browser_download_url' | grep zip | grep -v signatures)" && \
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
