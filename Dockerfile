FROM hydaz/baseimage-alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Duplicati version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ENV HOME="/config"

RUN set -xe && \
	echo "**** install packages ****" && \
	curl -o \
		/etc/apk/keys/hydaz.rsa.pub \
		"https://packages.hyde.services/hydaz.rsa.pub" && \
	echo "https://packages.hyde.services/alpine/apk" >>/etc/apk/repositories && \
	apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
		ca-certificates-mono \
		jq \
		libgdiplus \
		mono-reference-assemblies-facades \
		sqlite-libs \
		terminus-font && \
	echo "**** install duplicati ****" && \
	mkdir -p /app/duplicati && \
	if [ -z ${VERSION} ]; then \
		VERSION=$(curl -sL "https://api.github.com/repos/duplicati/duplicati/releases" | \
			jq -r 'first(.[] | select(.tag_name | contains("beta"))) | .tag_name'); \
	fi && \
	curl -o \
		/tmp/duplicati.zip -L \
		"$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/${VERSION} | \
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
