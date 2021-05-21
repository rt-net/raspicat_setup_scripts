#!/usr/bin/env bash

set -eu

[ -d /home/pi ] && HOME=/home/pi || HOME=/home/ubuntu

sudo /sbin/insmod $HOME/RaspberryPiMouse/src/drivers/rtmouse.ko || sudo /bin/bash $HOME/RaspberryPiMouse/utils/build_install.bash
sleep 1
sudo /bin/chmod 666 /dev/rt*
sleep 1
/bin/echo 0 > /dev/rtmotoren0


while true
do
if grep -q 0 /dev/rtswitch0; then
	sleep 0.1
	while grep -q 0 /dev/rtswitch0; do
		sleep 0.1
	done
	break;
fi
echo 1 | tee /dev/rtled?
sleep 0.3
echo 0 | tee /dev/rtled?
sleep 0.3
done

