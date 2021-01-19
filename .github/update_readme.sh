#!/bin/bash

DUPLICATI=$(echo "${APP_VERSION}" | cut -c 2-8)
MONO=$(grep <package_versions.txt -E "mono-runtime.*?-" | sed -n 1p | cut -c 14- | sed -E 's/-r.*//g')

echo "## docker-duplicati

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/duplicati) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/duplicati?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-duplicati/actions?query=workflow%3A\"Auto+Builder+CI\") [![codacy branch grade](https://img.shields.io/codacy/grade/c19bcbbcc7294555a8ec5478bad925bb/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-duplicati)

Fork of [linuxserver/docker-duplicati](https://github.com/linuxserver/docker-duplicati/)

**Make sure to do a test backup before relying on this image**

[Duplicati](https://www.duplicati.com/) is a free backup software to store encrypted backups online, Duplicati works with standard protocols like FTP, SSH, WebDAV as well as popular services like Microsoft OneDrive, Amazon Cloud Drive and S3, Google Drive, box.com, Mega, hubiC and many others.

## Version Information

![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![mono](https://img.shields.io/badge/mono-${MONO}-blue?style=for-the-badge) ![duplicati](https://img.shields.io/badge/duplicati-${DUPLICATI}-blue?style=for-the-badge)

See [package_versions.txt](package_versions.txt) for a full list of the packages and package versions used in this image

## Usage

    docker run -d \\
      --name=duplicati \\
      -e PUID=1000 \\
      -e PGID=1000 \\
      -e TZ=Australia/Melbourne \\
      -e CLI_ARGS= \`#optional\` \\
      -e DEBUG=true/false \`#optional\` \\
      -e PRIVILEGED=true/false \`#optional\` \\
      -p 8200:8200 \\
      -v <path to appdata>:/config \\
      -v <path to backups>:/backups \\
      -v <path to source>:/source \\
      --restart unless-stopped \\
      vcxpz/duplicati

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/duplicati.xml)

## New Environment Variables

### Debug

| Name    | Description                                                                                              | Default Value |
| ------- | -------------------------------------------------------------------------------------------------------- | ------------- |
| \`DEBUG\` | set \`true\` to display errors in the Docker logs. When set to \`false\` the Docker log is completely muted. | \`false\`       |

### Privileged

| Name         | Description                                                                                                                                                                                                   | Default Value |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| \`PRIVILEGED\` | Set \`true\` to run Duplicati as root. **This is not recommended**, but is useful if you have a script that runs before/after a backup that requires root permissions. i.e. stops/starts all docker containers. | \`false\`       |

**See other variables on the official [README](https://github.com/linuxserver/docker-duplicati/)**

## Upgrading Duplicati

To upgrade, all you have to do is pull our latest Docker image. We automatically check for Duplicati updates daily so there may be some delay when an update is released to when the image is updated.

## Credits

-   [hotio](https://github.com/hotio) for the \`redirect_cmd\` function" >README.md