#!/bin/bash

if [ "$DUPLICATI__OPERATIONNAME" = "Backup" ]; then
    docker start $(cat /config/scripts/containers.txt)
    rm /config/scripts/containers.txt
fi

exit 0
