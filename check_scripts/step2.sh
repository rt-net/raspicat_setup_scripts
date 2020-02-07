#!/usr/bin/env bash
set -eu

echo "Raspberry Pi Catテストスクリプト step2 Version 0.0.1"
for i in `seq 0 2`; do
	grep -q 1 /dev/rtswitch${i} || { echo "SW${i}エラー"; exit 1; }
done

for i in `seq 0 2`; do
	echo "SW${i}を押してください。"
	while $(grep -q 1 /dev/rtswitch${i}); do
		sleep 0.1
	done
	grep -q 0 /dev/rtswitch${i} && echo "SW${i} OK"
done
echo "SW0〜2 OK"
