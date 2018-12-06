#!/usr/bin/env bash
set -eu

echo "Raspberry Pi Catテストスクリプト step3 Version 0.0.1"
echo "2秒間、0.1秒間隔で音が鳴ります。"
array=(440 880)
for i in $(seq 10); do
	for i in ${array[@]}; do
		echo $i > /dev/rtbuzzer0
		sleep 0.1
	done
done
echo 0 > /dev/rtbuzzer0
read -p "音は鳴りましたか？ (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "エラー" ; exit 1 ;; esac
