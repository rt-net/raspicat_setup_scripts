#!/usr/bin/env bash
set -eu

if [ ! ${EUID:-${UID}} = 0 ]; then
	echo "You need to run this script as root." && exit 1
fi

systemctl disable raspicat.service
systemctl disable rosbase.service
