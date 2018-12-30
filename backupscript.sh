#!/bin/sh

# Linux Automated Backup Script
# Version: 1.0
# Script by: Cedric De Witte - Kwinten Braet - Sam Strobbe
# Support: info@cedricdewitte.be - info@kwintenbraet.be

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

echo 'Checking hostsystem...'


function check_webapp {

curl -I localhost > server.txt

if grep -q "apache" server.txt; then 
	echo Apache is being used!;
	check_os_apache
elif grep -q "nginx" server.txt; then 
	echo Nginx is being used!;
	nginx_folders
else
	echo No Webserver found!
fi
}

function check_os_apache {
cat /proc/version >> server.txt
cat /etc/redhat-release >> server.txt

if grep -q "Debian" server.txt; then 
	echo Debian is being used!;
	apache_folders_debian;

elif grep -q "Ubuntu" server.txt; then 
	echo Ubuntu is being used!;
	apache_folders_ubuntu;

elif grep -q "CentOS" server.txt; then 
	echo CentOS is being used!;
	apache_folders_centos;

else 
	echo OS not supported!
fi
	
}

function apache_folders_debian {

read -p "Do you want to do a complete back-up (A) or choose what you want to back-up (B)? ";
if [ $REPLY == "A" ]; then
#TODO CDW
    echo Backing up every folder...;
	cp -r /var/www $DIR;
	cp -r /etc/apache2 $DIR;
	cp -r /var/lib/mysql $DIR;
	cp -r /etc/ssl/certs $DIR;
	cp -r /run/apache2 $DIR;
	cp -r /var/run/apache2 $DIR;
fi

else 
	apache_folders_debian_choose
}





function apache_folders_debian_choose {

read -p "Do you want to backup folder /var/www? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /var/www $DIR;
fi

read -p "Do you want to backup folder /etc/apache2? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /etc/apache2 $DIR;
fi

read -p "Do you want to backup folder /var/lib/mysql? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /var/lib/mysql $DIR;
fi

read -p "Do you want to backup folder /etc/ssl/certs? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /etc/ssl/certs $DIR;
fi

read -p "Do you want to backup folder /run/apache2? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /run/apache2 $DIR;
fi

read -p "Do you want to backup folder /var/run/apache2? ";
if [ $REPLY == "y" ]; 
#TODO CDW
    echo Backing up folder...;
	cp -r /var/run/apache2 $DIR;
fi
}

function apache_folders_ubuntu {

read -p "Do you want to do a complete back-up (A) or choose what you want to back-up (B)? ";
if [ $REPLY == "A" ]; then
#TODO CDW
    echo Backing up every folder...;
	cp -r /var/www $DIR;
	cp -r /etc/httpd $DIR;
	cp -r /var/lib/mysql $DIR;
	cp -r /etc/ssl/certs $DIR;
	cp -r /run/httpd $DIR;
	cp -r /var/run/httpd $DIR;
fi

else 
	apache_folders_ubuntu_choose
	
}

function apache_folders_ubuntu_choose {

read -p "Do you want to backup folder /var/www? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /var/www $DIR;
fi

read -p "Do you want to backup folder /etc/httpd? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /etc/httpd $DIR;
fi

read -p "Do you want to backup folder /var/lib/mysql? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /var/lib/mysql $DIR;
fi

read -p "Do you want to backup folder /etc/ssl/certs? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /etc/ssl/certs $DIR;
fi

read -p "Do you want to backup folder /run/httpd? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /run/httpd $DIR;
fi

read -p "Do you want to backup folder /var/run/httpd? ";
if [ $REPLY == "y" ]; 
#TODO CDW
    echo Backing up folder...;
	cp -r /var/run/httpd $DIR;
fi
}





####  NGINX ####


function nginx_folders {

read -p "Do you want to do a complete back-up (A) or choose what you want to back-up (B)? ";
if [ $REPLY == "A" ]; then
#TODO CDW
    echo Backing up every folder...;
	cp -r /usr/share/nginx $DIR;
	cp -r /etc/nginx $DIR;
	cp -r /usr/local/nginx/conf $DIR;
	cp -r /usr/local/etc/nginx $DIR;
	cp -r /var/lib/mysql $DIR;
	cp -r /etc/ssl/certs $DIR;
	cp -r /run/nginx.pid $DIR;
	cp -r /var/run/nginx.pid $DIR;
fi

else 
	nginx_folders_debian_choose
	
}

function nginx_folders_choose {

read -p "Do you want to backup folder /usr/share/nginx? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /usr/share/nginx $DIR;
fi

read -p "Do you want to backup folder /etc/nginx? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /etc/nginx $DIR;
fi

read -p "Do you want to backup folder /usr/local/nginx/conf? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /usr/local/nginx/conf $DIR;
fi

read -p "Do you want to backup folder /usr/local/etc/nginx? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /usr/local/etc/nginx $DIR;
fi

read -p "Do you want to backup folder /var/lib/mysql? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /var/lib/mysql $DIR;
fi

read -p "Do you want to backup folder /etc/ssl/certs? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /etc/ssl/certs $DIR;
fi

read -p "Do you want to backup folder /run/nginx.pid? ";
if [ $REPLY == "y" ]; then
#TODO CDW
    echo Backing up folder...;
	cp -r /run/nginx.pid $DIR;
fi

read -p "Do you want to backup folder /var/run/nginx.pid? ";
if [ $REPLY == "y" ]; 
#TODO CDW
    echo Backing up folder...;
	cp -r /var/run/nginx.pid $DIR;
fi
}


check_webapp

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