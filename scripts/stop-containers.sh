#!/bin/bash

# containers to not stop, should be appdata without databases or excluded from backup
excludes="Duplicati container1 container2..."
# change `Duplicati` to the name of this container

if [ "$DUPLICATI__OPERATIONNAME" = "Backup" ]; then
	containers=$(docker ps | awk '{print $NF}' | awk '!/NAME/')
	for i in $excludes; do
		containers=$(echo "$containers" | awk "!/${i}/")
	done
	echo $containers >/config/scripts/containers.txt
	docker stop $containers
fi

exit 0
