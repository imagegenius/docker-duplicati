#!/bin/bash

if [ "$DUPLICATI__OPERATIONNAME" = "Backup" ]; then
	# do stuff on backup
fi

# duplicati doesn't like it when we don't manually exit with code 0
exit 0
