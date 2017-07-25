##    BACKUP SCRIPT FOR /etc and HASS Data       ##
###################################################
##    OLD BACKUPS WILL BE DELETED AFTER 14 DAYS! ##

#!/bin/bash

# Define Folders and Timestamp

DATE=$(date +%Y-%m-%d-%H%M%S)
BACKUP_DIR="/root/backups"
HOMEASSISTANT="/home/homeassistant/.homeassistant"
HOMEASSISTANT_SCRIPT="/home/homeassistant/script"
USERCONF="/home/pi/script /home/pi/.bashrc /root/scripts"
SOURCE="/etc"

# Stop HA, run the Backup, restart HA
echo Stoppe HomeAssistant.
sudo systemctl stop home-assistant@homeassistant.service

echo Beginne Backup der Verzeichnisse.

sudo tar -cjpf $BACKUP_DIR/etc-backup-$DATE.tar.bz2 $SOURCE
sudo tar -cjpf $BACKUP_DIR/homeassistant-complete-$DATE.tar.bz2 $HOMEASSISTANT
sudo tar -cjpf $BACKUP_DIR/homeassistant-scripts-$DATE.tar.bz2 $HOMEASSISTANT_SCRIPT
sudo tar -cjpf $BACKUP_DIR/user-scripts-$DATE.tar.bz2 $USERCONF

# bzip2 the SQL Dump would take ages...
# Won't backup the sqldata since the server runs on the NAS
#echo Beginne SQLDump.
#sudo mysqldump --lock-tables -h 192.168.0.11 -u ha -pha ha > $BACKUP_DIR/homeassistant-sqlbkp_$DATE.bak 
echo Starte HomeAssistant.
sudo systemctl start home-assistant@homeassistant.service

echo Lösche alte Backups und Kopiere auf das NAS.

# Delete old backups
sudo find $BACKUP_DIR -mtime +14 -exec rm {} \;
# Copy Backups to NAS
sudo mount /root/habackup_qnap
sudo cp -rv $BACKUP_DIR/ /root/habackup_qnap/
sudo umount /root/habackup_qnap
echo Backup complete.


