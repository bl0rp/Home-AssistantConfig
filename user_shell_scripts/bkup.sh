##    BACKUP SCRIPT FOR /etc and HASS Data       ##
###################################################
##    OLD BACKUPS WILL BE DELETED AFTER 14 DAYS! ##

#!/bin/bash

# Define Folders and Timestamp

DATE=$(date +%Y-%m-%d-%H%M%S)
BACKUP_DIR="/root/backups"
HOMEASSISTANT="/home/homeassistant/.homeassistant"
SOURCE="/etc"

# Stop HA, run the Backup, restart HA
systemctl stop home-assistant@homeassistant.service
tar -cjpf $BACKUP_DIR/etc-backup-$DATE.tar.bz2 $SOURCE
tar -cjpf $BACKUP_DIR/homeassistant-complete-$DATE.tar.bz2 $HOMEASSISTANT
# bziping the sqldump would take ages...
mysqldump --lock-tables -h 127.0.0.1 -u ha -pha homeassistant > $BACKUP_DIR/homeassistant-sqlbkp_$DATE.bak
systemctl start home-assistant@homeassistant.service

# Delete old backups
find $BACKUP_DIR -mtime +14 -exec rm {} \;

echo Backup complete.
