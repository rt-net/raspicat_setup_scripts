#!/usr/bin/env bash
set -eu

echo "Raspberry Pi Catテストスクリプト step1 Version 0.0.2"
echo "LED0～3が順番に点滅していれば問題ありません。Ctrl - Cで停止してください。"
while true; do
	echo 1 | tee /dev/rtled0 1>/dev/null
	sleep 0.1
	echo 0 | tee /dev/rtled0 1>/dev/null
	echo 1 | tee /dev/rtled1 1>/dev/null
	sleep 0.1
	echo 0 | tee /dev/rtled1 1>/dev/null
	echo 1 | tee /dev/rtled2 1>/dev/null
	sleep 0.1
	echo 0 | tee /dev/rtled2 1>/dev/null
	echo 1 | tee /dev/rtled3 1>/dev/null
	sleep 0.1
	echo 0 | tee /dev/rtled3 1>/dev/null
	sleep 1
done
