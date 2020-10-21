#!/bin/bash

PATH=/sys/class/backlight/intel_backlight

MAX=`/usr/bin/cat $PATH/max_brightness`
ATUAL=`/usr/bin/cat $PATH/brightness`

if [[ "$#" < 2 ]]; then
	echo "Usage:"
	echo "    control-brightness inc [percentage]"
	echo "    control-brightness dec [percentage]"
	exit 1
fi

OP=$1
VALUE=$2
VALUE=$(($VALUE * $MAX / 100))

if [[ "$OP" == "inc" ]]; then
	NEW_VALUE=$((ATUAL + VALUE))
fi

if [[ "$OP" == "dec" ]]; then
	NEW_VALUE=$((ATUAL - VALUE))
fi

if [ $NEW_VALUE -gt $MAX ]; then
	NEW_VALUE=$MAX
fi

if [ "$NEW_VALUE" -lt "0" ]; then
	NEW_VALUE=0
fi

# echo "Old value: $ATUAL"

echo "New value: $NEW_VALUE"
echo "$NEW_VALUE" > $PATH/brightness

