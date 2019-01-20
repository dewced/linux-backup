#!/bin/bash

# Linux Automated Backup Script
# Version: 1.0
# Script by: Cedric De Witte - Kwinten Braet - Sam Strobbe
# Support: info@cedricdewitte.be - info@kwintenbraet.be

########################################
# Please fill in your relevant details #
########################################

# FTP Credentials
USERNAME="cedricdwsam"
PASSWORD="linuxbackup"
SERVER="cedric.store"
PORT="21"

#Please do comment out the folders which you like to backup:

#WEB FOLDERS
#"/var/www"

#TODO: DIR is dus het mapje dat je naar de remote server kan duwen. Als we dus iets maken dat ofwel per gekozen mapje, iedere keer onderstaand script triggert.
#kunnen we de opslag nodig minimaliseren. Wat is de workflow dus?
#1. Loop elke map dat gebackupt moet worden 1 voor 1 af. Dus we starten MAP 1
#2. ZIPPEN dit en zetten het in DIR
#3. Trigger SFTP en upload.
#4. Maak DIR map leeg (doet hij dus al)
#5. Herhaal stappen met volgende map die je moet backuppen

# Where do I need to backup? (TODO: Extend to multiple folders, allow to choose)
DIR="/root/BACKUPDIR"

#Remote directory where the backup will be stored
REMOTEDIR="./"

#Filename of backup file to be transfered // DO NOT ADD EXTENSION
FILE="BACKUP_NAME"

#Which protocol do you prefer?
#1=FTP
#2=SFTP (requires apt-get install sshpass)
TYPE=1

echo 'Checking hostsystem...'

RED='\033[0;31m'
GREEN='\e[32m'

check_webapp() {

curl -I localhost > server.txt 2> /dev/null

if grep -q "Apache" server.txt; then
	 echo -e "${GREEN}Apache is being used!\e[0m";
	check_os_apache
elif grep -q "Nginx" server.txt; then
	echo -e "${GREEN}Nginx is being used!\e[0m";
	nginx_folders
else
    echo -e "${RED}No Webserver found!\e[0m";

fi
}

check_os_apache() {
cat /proc/version >> server.txt 2> /dev/null
cat /etc/redhat-release >> server.txt 2> /dev/null

if grep -q "Debian" server.txt; then
	echo -e "${GREEN}Debian is being used!\e[0m";
	apache_folders_debian;

elif grep -q "Ubuntu" server.txt; then
	echo -e "${GREEN}Ubuntu is being used!\e[0m";
	apache_folders_ubuntu;

elif grep -q "CentOS" server.txt; then
	echo -e "${GREEN}CentOS is being used!\e[0m";
	apache_folders_centos;

else
	echo -e "${RED}OS not supported!\e[0m";

fi

}

apache_folders_debian() {

echo "Do you want to do a complete back-up (1) or choose what you want to back-up (2)?"
read debian1
if [ $debian1 -eq 1 ]
then
	echo "Backing up every folder..."
	cp -r /var/www $DIR;
	cp -r /etc/apache2 $DIR;
	cp -r /var/lib/mysql $DIR;
	cp -r /etc/ssl/certs $DIR;
	cp -r /run/apache2 $DIR;
	cp -r /var/run/apache2 $DIR;
else
	if [ $debian1 -eq 2 ]
	then
		apache_folders_debian_choose
		echo "001"
	fi
fi
}


apache_folders_debian_choose() {

echo "Do you want to backup folder /var/www? (1 for yes)"
read debian2
if [ $debian2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/www $DIR;
	echo "done copying..."
fi

echo "Do you want to backup folder /etc/apache2? (1 for yes)"
read debian3
if [ $debian3 -eq 1 ]
then
  echo "Backing up folder...;"
    cp -r /etc/apache2 $DIR;
    echo "Done backing-up."
fi

echo "Do you want to backup folder /var/lib/mysql? (1 for yes)"
read debian4
if [ $debian4 -eq 1 ]
then
  echo "Backing up folder..."
  cp -r /var/lib/mysql $DIR;
  echo "Done backing-up."
fi
#

echo "Do you want to backup folder /etc/ssl/certs? (1 for yes)"
read debian5
if [ $debian5 -eq 1 ]
then
  echo "Backing up folder..."
  cp -r /etc/ssl/certs $DIR;
  echo "Done backing-up."
fi

echo "Do you want to backup folder /run/apache2? (1 for yes)"
read debian6
if [ $debian6 -eq 1 ]
then
  echo "Backing up folder..."
  cp -r /run/apache2 $DIR;
  echo "Done backing-up."
fi

echo "Do you want to backup folder /var/run/apache2? (1 for yes)"
read debian7
if [ $debian7 -eq 1 ]
then
  echo "Backing up folder..."
  cp -r /var/run/apache2 $DIR;
  echo "Done backing-up."
fi

}

apache_folders_ubuntu() {

echo "Do you want to do a complete back-up (1) or choose what you want to back-up (2)?"
read ubuntu1
if [ $ubuntu1 -eq 1 ]
then
    echo Backing up every folder...;
	cp -r /var/www $tDIR;
	cp -r /etc/httpd $DIR;
	cp -r /var/lib/mysql $DIR;
	cp -r /etc/ssl/certs $DIR;
	cp -r /run/httpd $DIR;
	cp -r /var/run/httpd $DIR;
else
	if [ $ubuntu1 -eq 2 ]
	then
		apache_folders_ubuntu_choose
		echo "001"
	fi
fi
}

apache_folders_ubuntu_choose() {

echo "Do you want to backup folder /var/www? (1 for yes)"
read ubuntu2
if [ $ubuntu2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/www $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /etc/httpd? (1 for yes)"
read ubuntu3
if [ $ubuntu3 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/httpd $DIR;
	echo "Done backing-up."
fi



echo "Do you want to backup folder /var/lib/mysql? (1 for yes)"
read ubuntu4
if [ $ubuntu4 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/lib/mysql $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /etc/ssl/certs? (1 for yes)"
read ubuntu5
if [ $ubuntu5 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/ssl/certs $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /run/httpd? (1 for yes)"
read ubuntu6
if [ $ubuntu6 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /run/httpd $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /var/run/httpd? (1 for yes)"
read ubuntu7
if [ $ubuntu7 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/run/httpd $DIR;
	echo "Done backing-up.."
fi

}

apache_folders_centos(){

echo "Do you want to do a complete back-up (1) or choose what you want to back-up (2)?"
read centos1
if [ $centos1 -eq 1 ]
then
    echo Backing up every folder...;
	cp -r /etc/httpd/conf.d $DIR;
	cp -r /var/www $DIR;
	cp -r /etc/httpd/conf $DIR;
	cp -r /etc/ssl/certs $DIR;
	cp -r /run/httpd $DIR;
	cp -r /var/run/httpd $DIR;
	echo "006"
else
	if [ $centos1 -eq 2 ]
	then
		apache_folders_centos_choose
		echo "001"
	fi
fi
}

apache_folders_centos_choose(){



echo "Do you want to backup folder /etc/httpd/conf.d? (1 for yes)"
read centos2
if [ $centos2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/httpd/conf.d $DIR;
	echo "Done backing-up.."
fi


echo "Do you want to backup folder /var/www/? (1 for yes)"
read centos3
if [ $centos3 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/www/ $DIR;
	echo "Done backing-up.."
fi



echo "Do you want to backup folder /etc/httpd/conf? (1 for yes)"
read centos4
if [ $centos4 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/httpd/conf $DIR;
	echo "Done backing-up.."
fi

echo "Do you want to backup folder /etc/ssl/certs? (1 for yes)"
read centos5
if [ $centos5 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/ssl/certs $DIR;
	echo "Done backing-up.."
fi



echo "Do you want to backup folder /run/httpd? (1 for yes)"
read centos6
if [ $centos6 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /run/httpd $DIR;
	echo "Done backing-up.."
fi



echo "Do you want to backup folder /var/run/httpd? (1 for yes)"
read centos7
if [ $centos7 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/run/httpd $DIR;
	echo "Done backing-up.."
fi

####  NGINX ####


nginx_folders() {

echo "Do you want to do a complete back-up (1) or choose what you want to back-up (2)?"
read nginx1
if [ $nginx1 -eq 1 ]
then
    echo Backing up every folder...;
	cp -r /usr/share/nginx $DIR;
	cp -r /etc/nginx $DIR;
	cp -r /usr/local/nginx/conf $DIR;
	cp -r /usr/local/etc/nginx $DIR;
	cp -r /var/lib/mysql $DIR;
	cp -r /etc/ssl/certs $DIR;
	cp -r /run/nginx.pid $DIR;
	cp -r /var/run/nginx.pid $DIR;
	echo "011"
else
	if [ $nginx1 -eq 2 ]
	then
		apache_folders_centos_choose
		echo "001"
	fi
fi

}

nginx_folders_choose() {


echo "Do you want to backup folder /usr/share/nginx? (1 for yes)"
read nginx2
if [ $nginx2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /usr/share/nginx $DIR;
	echo "Done backing-up.."
fi

echo "Do you want to backup folder /etc/nginx? (1 for yes)"
read nginx3
if [ $nginx3 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/nginx $DIR;
	echo "Done backing-up.."
fi


echo "Do you want to backup folder /usr/local/nginx/conf? (1 for yes)"
read nginx4
if [ $nginx4 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /usr/local/nginx/conf $DIR;
	echo "Done backing-up.."
fi

echo "Do you want to backup folder /usr/local/etc/nginx? (1 for yes)"
read nginx5
if [ $nginx5 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /usr/local/etc/nginx $DIR;
	echo "Done backing-up.."
fi

echo "Do you want to backup folder /var/lib/mysql? (1 for yes)"
read nginx6
if [ $nginx6 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/lib/mysql $DIR;
	echo "Done backing-up.."
fi

echo "Do you want to backup folder /etc/ssl/certs? (1 for yes)"
read nginx7
if [ $nginx7 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/ssl/certs $DIR;
	echo "Done backing-up.."
fi

echo "Do you want to backup folder /run/nginx.pid? (1 for yes)"
read nginx8
if [ $nginx8 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /run/nginx.pid $DIR;
	echo "Done backing-up.."
fi


echo "Do you want to backup folder /var/run/nginx.pid? (1 for yes)"
read nginx9
if [ $nginx9 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/run/nginx.pid $DIR;
	echo "Done backing-up.."
fi


check_webapp

##############################
# DO NOT ADD CHANGES BELOW! #
##############################
d=$(date --iso)

FILE=$FILE"_"$d".tar.gz"
tar -czvf ./$FILE $DIR
echo -e "${GREEN}Zipping it is complete!\e[0m"

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
echo -e "${RED}Please select a valid type\e[0m"
fi

echo -e "${GREEN}Remote Backup Complete\e[0m"

#END

cleanlocaltempbackup() {
  rm -f /root/BACKUPDIR
  echo -e "${GREEN}Local Backup Has Been Removed\e[0m"
}

cleanlocaltempbackup
