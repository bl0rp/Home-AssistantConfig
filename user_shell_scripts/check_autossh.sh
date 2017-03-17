#!/bin/bash

if pgrep -x "autossh" > /dev/null
then
    echo "Running"
else
    echo "Stopped"
fi
