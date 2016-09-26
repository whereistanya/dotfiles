#!/bin/bash

while [ 1 ]
do
    BATTERY=`acpi -b | grep -P -o '[0-9]+(?=%)'`

    if [[ "$BATTERY" -lt "10" ]]; then
      notify-send --urgency=critical --expire-time=1000  "Battery low" "Battery level is ${BATTERY}%!"
    fi

sleep 60

done
