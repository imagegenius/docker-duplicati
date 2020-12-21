## Alpine Edge fork of [linuxserver/docker-duplicati](https://github.com/linuxserver/docker-duplicati/)
[Duplicati](https://www.duplicati.com/) works with standard protocols like FTP, SSH, WebDAV as well as popular services like Microsoft OneDrive, Amazon Cloud Drive & S3, Google Drive, box.com, Mega, hubiC and many others.

**Make sure to do a test backup before relying on this image**

[![Docker hub](https://img.shields.io/badge/docker%20hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/duplicati) ![Docker Image Size](https://img.shields.io/docker/image-size/vcxpz/duplicati?style=for-the-badge&logo=docker) [![Autobuild](https://img.shields.io/badge/auto%20build-daily-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-duplicati/actions?query=workflow%3A%22Docker+Update+CI%22)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6overlay](https://img.shields.io/badge/s6--overlay-2.1.0.2-blue?style=for-the-badge) ![mono](https://img.shields.io/badge/mono-6.8.0.123-blue?style=for-the-badge) ![duplicati](https://img.shields.io/badge/duplicati-2.0.5.1-blue?style=for-the-badge) [![moredetail](https://img.shields.io/badge/more-detail-blue?style=for-the-badge)](https://github.com/hydazz/docker-duplicati/blob/main/package_versions.txt)

## Usage
```
docker run -d \
  --name=duplicati \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e CLI_ARGS= `#optional` \
  -p 8200:8200 \
  -v <path to appdata>:/config \
  -v <path to backups>:/backups \
  -v <path to source>:/source \
  --restart unless-stopped \
  vcxpz/duplicati
```

## Todo
* Nothing, everything works 🙂
