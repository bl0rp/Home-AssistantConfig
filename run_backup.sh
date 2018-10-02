##    BACKUP SCRIPT FOR /etc, HASS and Docker Data ##
#####################################################
##    OLD BACKUPS WILL BE DELETED AFTER 14 DAYS!   ##

#!/bin/bash

# Files for BACKUP

HOMEASSISTANT="/home/homeassistant/.homeassistant"
HOMEASSISTANT_SCRIPT="/home/homeassistant/script"
USERCONF="/home/chris/script /home/chris/.zshrc /root/script"
DOCKERDATA="/var/dockerfiles/grafana /var/dockerfiles/influxdb"
ETC="/etc"

# Where to backup to.
BACKUP_DIR="/root/backups"

# Create archive filename.
DATE=$(date +%Y-%m-%d-%H%M%S)
HOSTNAME=$(hostname -s)
ARCHIVE_FILE="$HOSTNAME-$DATE"

# Stop HA/Docker, run the Backup, restart HA/Docker
echo Stoppe HomeAssistant.
systemctl stop home-assistant@homeassistant.service

echo Stoppe DockerContainer
docker stop influxdb
docker stop grafana

# Print start status message.
echo "Backing up to $BACKUP_DIR/$ARCHIVE_FILE"
date
echo

# Backup the files using tar.
tar cfp $BACKUP_DIR/$ARCHIVE_FILE-HASS.tar $HOMEASSISTANT
tar cfp $BACKUP_DIR/$ARCHIVE_FILE-DOCKERDATA.tar $DOCKERDATA
tar cfp $BACKUP_DIR/$ARCHIVE_FILE-ETC.tar $ETC
tar cfp $BACKUP_DIR/$ARCHIVE_FILE-HASS-SCRIPT.tar $HOMEASSISTANT_SCRIPT
tar cfp $BACKUP_DIR/$ARCHIVE_FILE-USERCONF.tar $USERCONF
# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $BACKUP_DIR

echo Starte HomeAssistant und Docker Container
docker start influxdb
docker start grafana
systemctl start home-assistant@homeassistant.service
