#!/usr/bin/env bash
set -eu

echo "Raspberry Pi Catテストスクリプト step1 Version 0.0.1"
echo "LED1〜4が点滅していれば問題ありません。Ctrl - Cで停止してください。"
while true; do
	echo 1 | tee /dev/rtled? 1>/dev/null
	sleep 0.3
	echo 0 | tee /dev/rtled? 1>/dev/null
	sleep 0.3
done
