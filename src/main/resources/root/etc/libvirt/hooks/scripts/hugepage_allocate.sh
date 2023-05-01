#!/bin/bash

pagesNeeded=$1

if [[ -z ${pagesNeeded} ]]; then
	echo "Invalid pages value '${pagesNeeded}'!" >&2
	exit 1
fi

currentPages=$(cat /proc/sys/vm/nr_hugepages)
pagesBefore=${currentPages}
echo -ne "pagesNeeded=${pagesNeeded} currentPages=${currentPages} "

targetPages=$(((pagesNeeded + currentPages)))
echo "targetPages=${targetPages}"

# Allocate hugepages below
echo -ne "Syncing, dropping caches and compacting memory... "
sync
echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null
echo 1 | sudo tee /proc/sys/vm/compact_memory > /dev/null
echo " done."

for (( c=1; c<=20; c++ )); do
	echo ${targetPages} > /proc/sys/vm/nr_hugepages #| sudo tee /proc/sys/vm/nr_hugepages > /dev/null
	currentPages=$(cat /proc/sys/vm/nr_hugepages)
	if [[ ${currentPages} == "${targetPages}" ]]; then
		break
	fi
	echo "Allocating pages, trying to reach ${targetPages}, current is ${currentPages}"
	sleep 1
	currentPages=$(cat /proc/sys/vm/nr_hugepages)
done

if [[ ${currentPages} != "${targetPages}" ]]; then
	echo "Failed to allocate ${targetPages}, current is ${currentPages}. Restoring back down to ${pagesBefore}" >&2
	echo "${pagesBefore}" | sudo tee /proc/sys/vm/nr_hugepages > /dev/null
	exit 1
fi

echo "All done, allocated pages ${pagesNeeded} up to current ${currentPages}"
exit 0
