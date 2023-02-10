<!-- DO NOT EDIT THIS FILE MANUALLY  -->

# [imagegenius/duplicati](https://github.com/imagegenius/docker-duplicati)

[![GitHub Release](https://img.shields.io/github/release/imagegenius/docker-duplicati.svg?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/imagegenius/docker-duplicati/releases)
[![GitHub Package Repository](https://shields.io/badge/GitHub%20Package-blue?logo=github&logoColor=ffffff&style=for-the-badge)](https://github.com/imagegenius/docker-duplicati/packages)
[![Jenkins Build](https://img.shields.io/jenkins/build?labelColor=555555&logoColor=ffffff&style=for-the-badge&jobUrl=https%3A%2F%2Fci.imagegenius.io%2Fjob%2FDocker-Pipeline-Builders%2Fjob%2Fdocker-duplicati%2Fjob%2Fmain%2F&logo=jenkins)](https://ci.imagegenius.io/job/Docker-Pipeline-Builders/job/docker-duplicati/job/main/)
[![IG CI](https://img.shields.io/badge/dynamic/yaml?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=CI&query=CI&url=https%3A%2F%2Fci-tests.imagegenius.io%2Fduplicati%2Flatest-main%2Fci-status.yml)](https://ci-tests.imagegenius.io/duplicati/latest-main/index.html)

Duplicati is a backup client that securely stores encrypted, incremental, compressed remote backups of local files on cloud storage services and remote file servers.

[![duplicati](https://github.com/linuxserver/docker-templates/raw/master/linuxserver.io/img/duplicati-icon.png)](https://www.duplicati.com/)

## Supported Architectures

We use Docker manifest for cross-platform compatibility. More details can be found on [Docker's website](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list).

To obtain the appropriate image for your architecture, simply pull `ghcr.io/imagegenius/duplicati:latest`. Alternatively, you can also obtain specific architecture images by using tags.

This image supports the following architectures:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ✅ | arm64v8-\<version tag\> |

## Version Tags

This image offers different versions via tags. Be cautious when using unstable or development tags, and read their descriptions carefully.

| Tag | Available | Description |
| :----: | :----: |--- |
| latest | ✅ | Latest beta release of Duplicati with an Alpine base. |

## Application Setup

The WebUI can be found at `http://your-ip:8200`.

This image is similar to [linuxserver/duplicati](https://github.com/linuxserver/docker-duplicati), but based on alpine.

## Usage

Example snippets to start creating a container:

### Docker Compose

```yaml
---
version: "2.1"
services:
  duplicati:
    image: ghcr.io/imagegenius/duplicati:latest
    container_name: duplicati
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Australia/Melbourne
      - CLI_ARGS= #optional
    volumes:
      - path_to_appdata:/config
      - path_to_backups:/backups
      - path_to_source:/source
      - /tmp:/tmp
    ports:
      - 8200:8200
    restart: unless-stopped
```

### Docker CLI ([Click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=duplicati \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e CLI_ARGS= `#optional` \
  -p 8200:8200 \
  -v path_to_appdata:/config \
  -v path_to_backups:/backups \
  -v path_to_source:/source \
  -v /tmp:/tmp \
  --restart unless-stopped \
  ghcr.io/imagegenius/duplicati:latest
```

## Container Variables

To configure the container, pass variables at runtime using the format `<external>:<internal>`. For instance, `-p 8080:80` exposes port `80` inside the container, making it accessible outside the container via the host's IP on port `8080`.

| Variable | Description |
| :----: | --- |
| `-p 8200` | WebUI Port |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Australia/Melbourne` | Specify a timezone to use, eg. Australia/Melbourne |
| `-e CLI_ARGS=` | Optionally specify any [CLI variables](https://duplicati.readthedocs.io/en/latest/07-other-command-line-utilities/) you want to launch the app with |
| `-v /config` | Appdata Path |
| `-v /backups` | Backup Destination Path |
| `-v /source` | Backup Source Path |
| `-v /tmp` | Temporary Uploads Path |

## Umask for running applications

All of our images allow overriding the default umask setting for services started within the containers using the optional -e UMASK=022 option. Note that umask works differently than chmod and subtracts permissions based on its value, not adding. For more information, please refer to the Wikipedia article on umask [here](https://en.wikipedia.org/wiki/Umask).

## User / Group Identifiers

To avoid permissions issues when using volumes (`-v` flags) between the host OS and the container, you can specify the user (`PUID`) and group (`PGID`). Make sure that the volume directories on the host are owned by the same user you specify, and the issues will disappear.

Example: `PUID=1000` and `PGID=1000`. To find your PUID and PGID, run `id user`.

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Updating the Container

Most of our images are static, versioned, and require an image update and container recreation to update the app. We do not recommend or support updating apps inside the container. Check the [Application Setup](#application-setup) section for recommendations for the specific image.

Instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull duplicati`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d duplicati`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull ghcr.io/imagegenius/duplicati:latest`
* Stop the running container: `docker stop duplicati`
* Delete the container: `docker rm duplicati`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

## Versions

* **01.26.23:** - rearrange init files.
* **01.03.23:** - Initial release.
