#!/usr/bin/env bash
set -eu

if [ ! ${EUID:-${UID}} = 0 ]; then
	echo "You need to run this script as root." && exit 1
fi

cp ./etc/systemd/system/raspicat.service /etc/systemd/system/raspicat.service
cp ./etc/systemd/system/rosbase.service /etc/systemd/system/rosbase.service
systemctl daemon-reload
systemctl enable raspicat.service
systemctl enable rosbase.service
echo 'Run "systemctl raspicat start" and "systemctl rosbase start"'
