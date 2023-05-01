#!/bin/bash

pushd "$(dirname "$0")" || exit 1
sudo mkdir -p /etc/libvirt/hooks/qemu.d
sudo cp -r --preserve=mode scripts /etc/libvirt/hooks/
sudo cp -r --preserve=mode qemu.d/sample /etc/libvirt/hooks/qemu.d/
sudo cp --preserve=mode qemu /etc/libvirt/hooks/

popd || exit 1
