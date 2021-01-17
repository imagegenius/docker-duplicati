#!/bin/bash
DUPLICATI_RELEASE=$(echo "${DUPLICATI_RELEASE}" | cut -c 2-8)
OVERLAY_VERSION=$(curl -sX GET "https://raw.githubusercontent.com/hydazz/docker-baseimage-alpine-mono/main/version_info.json" | jq -r .overlay_version)
MONO_VERSION=$(grep <package_versions.txt -E "mono-runtime.*?-" | sed -n 1p | cut -c 14- | sed -E 's/-r.*//g')

OLD_OVERLAY_VERSION=$(jq <version_info.json -r .overlay_version)
OLD_MONO_VERSION=$(jq <version_info.json -r .mono_version)
OLD_DUPLICATI_RELEASE=$(jq <version_info.json -r .duplicati_release)

sed -i \
	-e "s/${OLD_OVERLAY_VERSION}/${OVERLAY_VERSION}/g" \
	-e "s/${OLD_MONO_VERSION}/${MONO_VERSION}/g" \
	-e "s/${OLD_DUPLICATI_RELEASE}/${DUPLICATI_RELEASE}/g" \
	README.md

NEW_VERSION_INFO="overlay_version|mono_version|duplicati_release
${OVERLAY_VERSION}|${MONO_VERSION}|${DUPLICATI_RELEASE}"

jq -Rn '
( input  | split("|") ) as $keys |
( inputs | split("|") ) as $vals |
[[$keys, $vals] | transpose[] | {key:.[0],value:.[1]}] | from_entries
' <<<"$NEW_VERSION_INFO" >version_info.json
