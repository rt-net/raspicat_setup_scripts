#!/usr/bin/env bash
set -eu

if [ ! ${EUID:-${UID}} = 0 ]; then
	echo "You need to run this script as root." && exit 1
fi

[ -d /home/ubuntu ] && NAME=ubuntu || NAME=pi

apt-get install screen || { apt-get update && apt-get install screen; }

if [ $NAME == "pi" ]; then
	cp ./etc/systemd/system/raspicat.service.pi /etc/systemd/system/raspicat.service
	systemctl daemon-reload
	systemctl enable raspicat.service
	echo 'Run "systemctl start raspicat"'
elif [ $NAME == "ubuntu" ]; then
	cp ./etc/systemd/system/raspicat.service.ubuntu /etc/systemd/system/raspicat.service
	cp ./etc/systemd/system/rosbase.service.ubuntu /etc/systemd/system/rosbase.service
	systemctl daemon-reload
	systemctl enable raspicat.service
	systemctl enable rosbase.service
	echo 'Run "systemctl start raspicat" and "systemctl start rosbase"'
else
	echo 'Your $HOME seems to be neither "/home/ubuntu" or "/home/pi".'
fi
