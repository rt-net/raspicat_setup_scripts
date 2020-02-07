#!/usr/bin/env bash
set -eu

echo "Raspberry Pi Catテストスクリプト step5 Version 0.0.1"
echo "超音波センサのチェックを行います。"
echo "対象とするセンサの前に手をかざし、値が小さく(200以下程度)なれば問題ありません。Ctrl - Cで停止してください。"

while true ; do
	SENSOR_VAL=`cat /dev/rtlightsensor0`
	L=`echo $SENSOR_VAL | grep -oP -e "\d*" | sed -n 4P`
	LF=`echo $SENSOR_VAL | grep -oP -e "\d*" | sed -n 3P`
	R=`echo $SENSOR_VAL | grep -oP -e "\d*" | sed -n 1P`
	RF=`echo $SENSOR_VAL | grep -oP -e "\d*" | sed -n 2P`
	echo L: $L, LF: $LF, RF: $RF, R: $R
	sleep 0.1
done
