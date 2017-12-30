#!/bin/bash

if pgrep -x "dhcpd" > /dev/null
then
    echo "Running"
else
    echo "Stopped"
fi
