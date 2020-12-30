## Alpine Edge fork of [linuxserver/docker-duplicati](https://github.com/linuxserver/docker-duplicati/)
[Duplicati](https://www.duplicati.com/) works with standard protocols like FTP, SSH, WebDAV as well as popular services like Microsoft OneDrive, Amazon Cloud Drive & S3, Google Drive, box.com, Mega, hubiC and many others.

**Make sure to do a test backup before relying on this image**

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/duplicati) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/duplicati?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/auto_build-weekly-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-duplicati/actions?query=workflow%3A%22Cron+Update+CI%22)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6 overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![mono](https://img.shields.io/badge/mono-6.12.0.107-blue?style=for-the-badge) ![duplicati](https://img.shields.io/badge/duplicati-2.0.5.1-blue?style=for-the-badge)

## Usage
```
docker run -d \
  --name=duplicati \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e CLI_ARGS= `#optional` \
  -e DEBUG=true/false `#optional` \
  -p 8200:8200 \
  -v <path to appdata>:/config \
  -v <path to backups>:/backups \
  -v <path to source>:/source \
  --restart unless-stopped \
  vcxpz/duplicati
```

## Credits
* [hotio](https://github.com/hotio) for the `redirect_cmd` function

## Todo
* Nothing, everything works 🙂
