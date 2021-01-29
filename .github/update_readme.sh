#!/bin/bash

DUPLICATI=$(echo "${APP_VERSION}" | cut -c 2-8)
MONO=$(grep <package_versions.txt -E "mono-runtime.*?-" | sed -n 1p | cut -c 14- | sed -E 's/-r.*//g')

sed -i -E \
	-e "s/mono-.*?-blue/mono-${MONO}-blue/g" \
	-e "s/duplicati-.*?-blue/duplicati-${DUPLICATI}-blue/g" \
	README.md
