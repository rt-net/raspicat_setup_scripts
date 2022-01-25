#!/usr/bin/env bash
set -eu

echo "Raspberry Pi Catテストスクリプト step4 Version 0.1.0"
echo "これからモータを回転させます。"
read -p "車体を平らな広いところに置いていますか？ (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "エラー" ; exit 1 ;; esac

ENCMAX=65535

echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
echo 1 > /dev/rtmotoren0

echo "TEST A"
ENC_R=$(cat /dev/rtcounter_r1)
ENC_L=$(cat /dev/rtcounter_l1)
echo 200 | tee /dev/rtmotor_raw_* 1>/dev/null
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
#$ENCMAX
DIFF_R=$(($(cat /dev/rtcounter_r1) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l1) - $ENC_L))
if [[ $DIFF_R -gt -$ENCMAX ]] && [[ $DIFF_R -lt 0 ]]; then
	DIFF_R=$(($DIFF_R + $ENCMAX))
fi
if [[ $DIFF_R -gt 150 ]] && [[ $DIFF_R -lt 500 ]]; then
	echo "RIGHT OK"
else
	echo "RIGHT ERROR"
	echo "echo 200 > /dev/rtmotor_raw_r0"
	echo "debug messege: right diff" $DIFF_R
fi

if [[ $DIFF_L -gt -$ENCMAX ]] && [[ $DIFF_L -lt 0 ]]; then
	DIFF_L=$(($DIFF_L + $ENCMAX))
fi
if [[ $DIFF_L -gt 150 ]] && [[ $DIFF_L -lt 500 ]]; then
	echo "LEFT OK"
else
	echo "LEFT ERROR"
	echo "echo 200 > /dev/rtmotor_raw_l0"
	echo "debug messege: left diff" $DIFF_L
fi

sleep 0.1

echo "TEST B"
ENC_R=$(cat /dev/rtcounter_r1)
ENC_L=$(cat /dev/rtcounter_l1)
echo -200 | tee /dev/rtmotor_raw_* 1>/dev/null
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
DIFF_R=$(($(cat /dev/rtcounter_r1) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l1) - $ENC_L))
if [[ $DIFF_R -lt $ENCMAX ]] && [[ $DIFF_R -gt 0 ]]; then
	DIFF_R=$(($DIFF_R - $ENCMAX))
fi
if [[ $DIFF_R -lt -150 ]] && [[ $DIFF_R -gt -500 ]]; then
	echo "RIGHT OK"
else
	echo "RIGHT ERROR"
	echo "echo -200 > /dev/rtmotor_raw_r0"
	echo "debug messege: right diff" $DIFF_R
fi
if [[ $DIFF_L -lt $ENCMAX ]] && [[ $DIFF_L -gt 0 ]]; then
	DIFF_L=$(($DIFF_L - $ENCMAX))
fi
if [[ $DIFF_L -lt -150 ]] && [[ $DIFF_L -gt -500 ]]; then
	echo "LEFT OK"
else
	echo "LEFT ERROR"
	echo "echo -200 > /dev/rtmotor_raw_l0"
	echo "debug messege: left diff" $DIFF_L
fi

sleep 0.1

echo "TEST C"
ENC_R=$(cat /dev/rtcounter_r1)
ENC_L=$(cat /dev/rtcounter_l1)
echo 200 > /dev/rtmotor_raw_r0
echo -200 > /dev/rtmotor_raw_l0
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
DIFF_R=$(($(cat /dev/rtcounter_r1) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l1) - $ENC_L))
if [[ $DIFF_R -gt -$ENCMAX ]] && [[ $DIFF_R -lt 0 ]]; then
	DIFF_R=$(($DIFF_R + $ENCMAX))
fi
if [[ $DIFF_R -gt 150 ]] && [[ $DIFF_R -lt 500 ]]; then
	echo "RIGHT OK"
else
	echo "RIGHT ERROR"
	echo "echo 200 > /dev/rtmotor_raw_r0"
	echo "debug messege: right diff" $DIFF_R
fi
if [[ $DIFF_L -lt $ENCMAX ]] && [[ $DIFF_L -gt 0 ]]; then
	DIFF_L=$(($DIFF_L - $ENCMAX))
fi
if [[ $DIFF_L -lt -150 ]] && [[ $DIFF_L -gt -500 ]]; then
	echo "LEFT OK"
else
	echo "LEFT ERROR"
	echo "echo -200 > /dev/rtmotor_raw_l0"
	echo "debug messege: left diff" $DIFF_L
fi

sleep 0.1

echo "TEST D"
ENC_R=$(cat /dev/rtcounter_r1)
ENC_L=$(cat /dev/rtcounter_l1)
echo -200 > /dev/rtmotor_raw_r0
echo 200 > /dev/rtmotor_raw_l0
sleep 1.0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
DIFF_R=$(($(cat /dev/rtcounter_r1) - $ENC_R))
DIFF_L=$(($(cat /dev/rtcounter_l1) - $ENC_L))
if [[ $DIFF_R -lt $ENCMAX ]] && [[ $DIFF_R -gt 0 ]]; then
	DIFF_R=$(($DIFF_R - $ENCMAX))
fi
if [[ $DIFF_R -lt -150 ]] && [[ $DIFF_R -gt -500 ]]; then
	echo "RIGHT OK"
else
	echo "RIGHT ERROR"
	echo "echo -200 > /dev/rtmotor_raw_r0"
	echo "debug messege: right diff" $DIFF_R
fi
if [[ $DIFF_L -gt -$ENCMAX ]] && [[ $DIFF_L -lt 0 ]]; then
	DIFF_L=$(($DIFF_L + $ENCMAX))
fi
if [[ $DIFF_L -gt 150 ]] && [[ $DIFF_L -lt 500 ]]; then
	echo "LEFT OK"
else
	echo "LEFT ERROR"
	echo "echo 200 > /dev/rtmotor_raw_l0"
	echo "debug messege: left diff" $DIFF_L
fi

echo 0 > /dev/rtmotoren0
echo 0 | tee /dev/rtmotor_raw_* 1>/dev/null
echo "ERRORが出ていなければOKです。"
