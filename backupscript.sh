#!/bin/sh

# Linux Automated Backup Script
# Version: 1.0
# Script by: Cedric De Witte - Kwinten Braet - Sam Strobbe
# Email: info@cedricdewitte.Be

########################################
# Please fill in your relevant details #
########################################

# FTP Credentials
USERNAME="USERNAME HERE"
PASSWORD="PASSWORD HERE"
SERVER="IP HERE"
PORT="REMOTE SERVER PORT"

#Please do comment out the folders which you like to backup:

#WEB FOLDERS
"/var/www"

#TODO: DIR is dus het mapje dat je naar de remote server kan duwen. Als we dus iets maken dat ofwel per gekozen mapje, iedere keer onderstaand script triggert.
#kunnen we de opslag nodig minimaliseren. Wat is de workflow dus?
#1. Loop elke map dat gebackupt moet worden 1 voor 1 af. Dus we starten MAP 1
#2. ZIPPEN dit en zetten het in DIR
#3. Trigger SFTP en upload.
#4. Maak DIR map leeg (doet hij dus al)
#5. Herhaal stappen met volgende map die je moet backuppen

# What do I need to backup? (TODO: Extend to multiple folders, allow to choose)
DIR="/root"

#Remote directory where the backup will be stored
REMOTEDIR="./"

#Filename of backup file to be transfered // DO NOT ADD EXTENSION
FILE="BACKUP_NAME"

#Which protocol do you prefer?
#1=FTP
#2=SFTP (requires apt-get install sshpass)
TYPE=1












##############################
# DO NOT ADD CHANGES BELOW! #
##############################
d=$(date --iso)

FILE=$FILE"_"$d".tar.gz"
tar -czvf ./$FILE $DIR
echo 'Zipping it is complete!'

if [ $TYPE -eq 1 ]
then
ftp -n -i $SERVER $PORT <<EOF
user $USERNAME $PASSWORD
binary
put $FILE $REMOTEDIR/$FILE
quit
EOF
elif [ $TYPE -eq 2 ]
then
rsync --rsh="sshpass -p $PASSWORD ssh -p $PORT -o StrictHostKeyChecking=no -l $USERNAME" $FILE $SERVER:$REMOTEDIR
else
echo 'Please select a valid type'
fi

echo 'Remote Backup Complete'
cleanlocaltempbackup
#END

cleanlocaltempbackup() {
  rm -f ./$FILE
  echo 'Local Backup Has Been Removed'
}