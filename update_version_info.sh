#!/bin/bash

DUPLICATI_RELEASE=$(echo $DUPLICATI_RELEASE | cut -c 2-8)
OVERLAY_VERSION=$(cat package_versions.txt | grep -E "s6-overlay.*?-" | sed -n 1p | cut -c 12- | sed -E 's/-r.*//g')
MONO_VERSION=$(cat package_versions.txt | grep -E "mono-runtime.*?-" | sed -n 1p | cut -c 14- | sed -E 's/-r.*//g')

OLD_OVERLAY_VERSION=$(cat version_info.json | jq -r .overlay_version)
OLD_MONO_VERSION=$(cat version_info.json | jq -r .mono_version)
OLD_DUPLICATI_RELEASE=$(cat version_info.json | jq -r .duplicati_release)

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
