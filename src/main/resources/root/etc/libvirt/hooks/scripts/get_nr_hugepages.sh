#!/bin/bash

domain=$1
memRegex='\s*<memory unit='\''([A-Za-z]+)'\''>([0-9]+)<\/memory>'
memInfo=$(virsh dumpxml "${domain}" | grep '<memory' | grep '</memory')

hugepageSize=$(grep Hugepagesize /proc/meminfo | cut -f2 -d: | sed 's/\s*//g')
if [[ ${hugepageSize} != "2048kB" ]]; then
	echo "Unknown hugepage size ${hugepageSize}" >&2
	exit 1
fi

pages=0
if [[ "${memInfo}" =~ ${memRegex} ]]; then
	unit="${BASH_REMATCH[1]}"
	mem="${BASH_REMATCH[2]}"
	case ${unit} in
		KiB)
			pages=$(((mem / 2048) + (mem % 2048 > 0)))
			;;
		MiB)
			pages=$(((mem / 2) + (mem % 2 > 0)))
			;;
		GiB)
			pages=$(((mem * 1024 / 2)))
			;;
		*)
			echo "Unknown unit ${unit}" >&2
			exit 1
			;;
	esac
else
	echo "Failed to parse domain memory info" >&2
	exit 1
fi

echo ${pages}
