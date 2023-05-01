#!/bin/bash

pages=$1
if [[ ${pages} -lt 0 ]]; then
	echo "Invalid number of pages to deallocate, needs to be >= 0" >&2
	exit 1
fi

currentPages=$(cat /proc/sys/vm/nr_hugepages)
targetPages=$(((currentPages - pages)))
echo "pages=${pages} currentPages=${currentPages} targetPages=${targetPages}"

if [[ ${targetPages} -lt 0 ]]; then
	targetPages=0
	echo "WARN: Target pages < 0, cannot fully deallocate" >&2
fi

echo ${targetPages} | sudo tee /proc/sys/vm/nr_hugepages > /dev/null

echo "All done, deallocated pages ${pages} down to current ${targetPages}"
exit 0
