#!/bin/bash

if pgrep -x "sshd" > /dev/null
then
    echo "Running"
else
    echo "Stopped"
fi
