#!/bin/bash
autossh -i /home/homeassistant/key/rootserver -NC -R 2342:localhost:8123 -R 12345:localhost:22 chris@rootserver &
