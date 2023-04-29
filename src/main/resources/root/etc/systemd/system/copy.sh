#!/bin/sh

for filename in *.service *.timer *.slice; do
	echo "${filename}"
	cp "/etc/systemd/system/${filename}" .
done
