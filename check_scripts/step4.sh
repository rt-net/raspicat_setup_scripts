#!/usr/bin/env bash
set -eu

echo "Raspberry Pi Catテストスクリプト step4 Version 0.0.1"
echo "これからモータを回転させます。"
read -p "ホイールは浮かせていますか？ (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "エラー" ; exit 1 ;; esac

echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
echo 1 > /dev/rtmotoren0
ENC_R=$(cat /dev/rtcounter_r0)
ENC_L=$(cat /dev/rtcounter_l0)
echo 400 | tee /dev/rtmotor_raw_* 1>/dev/null
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
#65535
DIFF_R=$(($(cat /dev/rtcounter_r0) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l0) - $ENC_L))
if [[ $DIFF_R -gt 400 ]] && [[ $DIFF_R -lt 800 ]]; then
	echo "RIGHT OK"
else
	if [[ $DIFF_R -gt -65535 ]] && [[ $DIFF_R -lt 0 ]]; then
		DIFF_R=$(($DIFF_R + 65535))
		if [[ $DIFF_R -gt 400 ]] && [[ $DIFF_R -lt 800 ]]; then
			echo "RIGHT OK"
		fi
	fi
	echo "echo 400 > /dev/rtmotor_raw_r0"
	echo "ERROR"
	echo "debug messege: right diff" $DIFF_R
fi
if [[ $DIFF_L -gt 400 ]] && [[ $DIFF_L -lt 800 ]]; then
	echo "LEFT OK"
else
	if [[ $DIFF_L -gt -65535 ]] && [[ $DIFF_L -lt 0 ]]; then
		DIFF_L=$(($DIFF_L + 65535))
		if [[ $DIFF_L -gt 400 ]] && [[ $DIFF_L -lt 800 ]]; then
			echo "LEFT OK"
		fi
	fi
	echo "echo 400 > /dev/rtmotor_raw_l0"
	echo "ERROR"
	echo "debug messege: left diff" $DIFF_L
fi

sleep 0.1

ENC_R=$(cat /dev/rtcounter_r0)
ENC_L=$(cat /dev/rtcounter_l0)
echo -400 | tee /dev/rtmotor_raw_* 1>/dev/null
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
DIFF_R=$(($(cat /dev/rtcounter_r0) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l0) - $ENC_L))
if [[ $DIFF_R -lt -400 ]] && [[ $DIFF_R -gt -800 ]]; then
	echo "RIGHT OK"
else
	if [[ $DIFF_R -lt 65535 ]] && [[ $DIFF_R -gt 800 ]]; then
		DIFF_R=$(($DIFF_R - 65535))
		if [[ $DIFF_R -lt -400 ]] && [[ $DIFF_R -gt -800 ]]; then
			echo "RIGHT OK"
		fi
	fi
	echo "echo -400 > /dev/rtmotor_raw_r0"
	echo "ERROR"
	echo "debug messege: right diff" $DIFF_R
fi
if [[ $DIFF_L -lt -400 ]] && [[ $DIFF_L -gt -800 ]]; then
	echo "LEFT OK"
else
	if [[ $DIFF_L -lt 65535 ]] && [[ $DIFF_L -gt 800 ]]; then
		DIFF_L=$(($DIFF_L - 65535))
		if [[ $DIFF_L -lt -400 ]] && [[ $DIFF_L -gt -800 ]]; then
			echo "LEFT OK"
		fi
	fi
	echo "echo -400 > /dev/rtmotor_raw_l0"
	echo "ERROR"
	echo "debug messege: left diff" $DIFF_L
fi

sleep 0.1

ENC_R=$(cat /dev/rtcounter_r0)
ENC_L=$(cat /dev/rtcounter_l0)
echo 400 > /dev/rtmotor_raw_r0
echo -400 > /dev/rtmotor_raw_l0
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
DIFF_R=$(($(cat /dev/rtcounter_r0) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l0) - $ENC_L))
if [[ $DIFF_R -gt 400 ]] && [[ $DIFF_R -lt 800 ]]; then
	echo "RIGHT OK"
else
	echo "ERROR"
	echo "echo 400 > /dev/rtmotor_raw_r0"
	echo "debug messege: right diff" $DIFF_R
fi
if [[ $DIFF_L -lt -400 ]] && [[ $DIFF_L -gt -800 ]]; then
	echo "LEFT OK"
else
	echo "ERROR"
	echo "echo -400 > /dev/rtmotor_raw_l0"
	echo "debug messege: left diff" $DIFF_L
fi

sleep 0.1

ENC_R=$(cat /dev/rtcounter_r0)
ENC_L=$(cat /dev/rtcounter_l0)
echo -400 > /dev/rtmotor_raw_r0
echo 400 > /dev/rtmotor_raw_l0
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
DIFF_R=$(($(cat /dev/rtcounter_r0) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l0) - $ENC_L))
if [[ $DIFF_R -lt -400 ]] && [[ $DIFF_R -gt -800 ]]; then
	echo "RIGHT OK"
else
	echo "ERROR"
	echo "echo -400 > /dev/rtmotor_raw_r0"
	echo "debug messege: right diff" $DIFF_R
fi
if [[ $DIFF_L -gt 400 ]] && [[ $DIFF_L -lt 800 ]]; then
	echo "LEFT OK"
else
	echo "ERROR"
	echo "echo 400 > /dev/rtmotor_raw_l0"
	echo "debug messege: left diff" $DIFF_L
fi

echo 0 > /dev/rtmotoren0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
echo "ERRORが出ていなければOKです。"
