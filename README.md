## docker-duplicati

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/duplicati) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/duplicati?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-duplicati/actions?query=workflow%3A"Auto+Builder+CI")

**This image has been adapted from [linuxserver/docker-duplicati](https://github.com/linuxserver/docker-duplicati/) (v2.0.6.3-2.0.6.3_beta_2021-06-17-ls135)**

#### Modifications:
| | Modified|
|--|--|
| Packages | N/A |
| Scripts | N/A |
| Base OS | Rebased to Alpine |
| Other | Added the `PRIVILEGED` variable, set to `true` and duplicati will run as root, useful if you need to control docker on the host in a script |

**Make sure to do a test backup before relying on this image**

[Duplicati](https://www.duplicati.com/) is a free backup software to store encrypted backups online, Duplicati works with standard protocols like FTP, SSH, WebDAV as well as popular services like Microsoft OneDrive, Amazon Cloud Drive and S3, Google Drive, box.com, Mega, hubiC and many others.

## Usage

```bash
docker run -d \
  --name=duplicati \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e CLI_ARGS= #optional \
  -e PRIVILEGED=true/false #optional \
  -p 8200:8200 \
  -v <path to appdata>:/config \
  -v <path to backups>:/backups \
  -v <path to source>:/source \
  --restart unless-stopped \
  vcxpz/duplicati
```

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/duplicati.xml)

**Read the official [README.md](https://github.com/linuxserver/docker-duplicati/) for more information**

## Upgrading Duplicati

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Duplicati updates daily. When a new version is released, we build and publish an image both as a version tag and on `:latest`.