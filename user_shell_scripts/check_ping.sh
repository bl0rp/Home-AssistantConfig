#!/bin/bash
ping -w 10 -c 1 192.168.0.111 >/dev/null && echo Ping works\! || echo Error
