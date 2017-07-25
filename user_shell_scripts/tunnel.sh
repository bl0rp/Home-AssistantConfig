#!/bin/bash
autossh -i /home/homeassistant/key/0x_nocrypt -NC -R 2342:localhost:8123 -R 12345:localhost:22 user@host &
