#!/bin/bash

# Linux Automated Backup Script
# Version: 1.0
# Script by: Cedric De Witte - Kwinten Braet - Sam Strobbe
# Support: info@cedricdewitte.be - info@kwintenbraet.be - sam.strobbe0309@hotmail.com



# WHAT IS IT?
# -----------
# This is a backup script for Linux that can back up an entire webserver and uploads the back-up to a FTP server.
#
# FEATURES
# --------
#
#  - Apache or Nginx webserver back-up script
#  - Made for Debian, Ubuntu & CentOS
#  - Make a full back-up of the webserver of choose which folders.

########################################
### BEGIN CONFIGURATION ###
########################################

### FTP Config ###
#
#
# The Username of your FTP Server.
#
USERNAME="Your username"
#
#
# The password of your FTP Server.
#
PASSWORD="Your password"
#
#
# The ip or hostname of your FTP Server.
#
SERVER="Your IP or hostname"
#
#
# The port your FTP server is using.
#
PORT="21"
#
#
# Which protocol do you prefer?
# 1=FTP
# 2=SFTP (requires apt-get install sshpass)
#
TYPE=1
#
#
# Remote FTP directory where the backup will be stored.
#
REMOTEDIR="./"
#
#

### Backup Config ###
#
#
# Where do you want need to place your backup locally?
#
DIR="/root/backup"
#
#
# Filename of backup file to be transfered // DO NOT ADD EXTENSION
FILE="BACKUP_NAME"
#
#
######################################################################################
### END CONFIGURATION ###
######################################################################################




function help {
	echo "
This is a backup script for Linux that can back up an entire webserver and uploads the back-up to a FTP server. You can choose to do a full back-up at once or choose the different folders.
*** If you get an Not Connected error. That means that the FTP Credentials you entered are wrong. ***"
}

if [ "${1}" == "--help" ]; then
	help
fi




# Create temporary directory
mkdir $DIR 2> /dev/null
echo "Your temporary backupdirectory has been created!"

echo "Checking hostsystem..."

RED='\033[0;31m'
GREEN='\e[32m'


# Check the webserver being used
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

# Check the OS being used
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

# Ask full back-up or choose folder.
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

echo "Do you want to backup folder /var/www? (Choose 1 for YES and 2 for NO)"
read debian2
if [ $debian2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/www $DIR;
	echo "done copying..."
fi

echo "Do you want to backup folder /etc/apache2? (Choose 1 for YES and 2 for NO)"
read debian3
if [ $debian3 -eq 1 ]
then
  echo "Backing up folder...;"
    cp -r /etc/apache2 $DIR;
    echo "Done backing-up."
fi

echo "Do you want to backup folder /var/lib/mysql? (Choose 1 for YES and 2 for NO)"
read debian4
if [ $debian4 -eq 1 ]
then
  echo "Backing up folder..."
  cp -r /var/lib/mysql $DIR;
  echo "Done backing-up."
fi
#

echo "Do you want to backup folder /etc/ssl/certs? (Choose 1 for YES and 2 for NO)"
read debian5
if [ $debian5 -eq 1 ]
then
  echo "Backing up folder..."
  cp -r /etc/ssl/certs $DIR;
  echo "Done backing-up."
fi

echo "Do you want to backup folder /run/apache2? (Choose 1 for YES and 2 for NO)"
read debian6
if [ $debian6 -eq 1 ]
then
  echo "Backing up folder..."
  cp -r /run/apache2 $DIR;
  echo "Done backing-up."
fi

echo "Do you want to backup folder /var/run/apache2? (Choose 1 for YES and 2 for NO)"
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
    echo "Backing up every folder...";
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

echo "Do you want to backup folder /var/www? (Choose 1 for YES and 2 for NO)"
read ubuntu2
if [ $ubuntu2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/www $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /etc/httpd? (Choose 1 for YES and 2 for NO)"
read ubuntu3
if [ $ubuntu3 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/httpd $DIR;
	echo "Done backing-up."
fi



echo "Do you want to backup folder /var/lib/mysql? (Choose 1 for YES and 2 for NO)"
read ubuntu4
if [ $ubuntu4 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/lib/mysql $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /etc/ssl/certs? (Choose 1 for YES and 2 for NO)"
read ubuntu5
if [ $ubuntu5 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/ssl/certs $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /run/httpd? (Choose 1 for YES and 2 for NO)"
read ubuntu6
if [ $ubuntu6 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /run/httpd $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /var/run/httpd? (Choose 1 for YES and 2 for NO)"
read ubuntu7
if [ $ubuntu7 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/run/httpd $DIR;
	echo "Done backing-up."
fi

}

apache_folders_centos(){

echo "Do you want to do a complete back-up (1) or choose what you want to back-up (2)?"
read centos1
if [ $centos1 -eq 1 ]
then
    echo "Backing up every folder...";
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



echo "Do you want to backup folder /etc/httpd/conf.d? (Choose 1 for YES and 2 for NO)"
read centos2
if [ $centos2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/httpd/conf.d $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /var/www/? (Choose 1 for YES and 2 for NO)"
read centos3
if [ $centos3 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/www/ $DIR;
	echo "Done backing-up."
fi



echo "Do you want to backup folder /etc/httpd/conf? (Choose 1 for YES and 2 for NO)"
read centos4
if [ $centos4 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/httpd/conf $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /etc/ssl/certs? (Choose 1 for YES and 2 for NO)"
read centos5
if [ $centos5 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/ssl/certs $DIR;
	echo "Done backing-up."
fi



echo "Do you want to backup folder /run/httpd? (Choose 1 for YES and 2 for NO)"
read centos6
if [ $centos6 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /run/httpd $DIR;
	echo "Done backing-up."
fi



echo "Do you want to backup folder /var/run/httpd? (Choose 1 for YES and 2 for NO)"
read centos7
if [ $centos7 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/run/httpd $DIR;
	echo "Done backing-up."
fi
}

####  NGINX ####


nginx_folders() {

echo "Do you want to do a complete back-up (1) or choose what you want to back-up (2)?"
read nginx1
if [ $nginx1 -eq 1 ]
then
    echo "Backing up every folder...";
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


echo "Do you want to backup folder /usr/share/nginx? (Choose 1 for YES and 2 for NO)"
read nginx2
if [ $nginx2 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /usr/share/nginx $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /etc/nginx? (Choose 1 for YES and 2 for NO)"
read nginx3
if [ $nginx3 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/nginx $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /usr/local/nginx/conf? (Choose 1 for YES and 2 for NO)"
read nginx4
if [ $nginx4 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /usr/local/nginx/conf $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /usr/local/etc/nginx? (Choose 1 for YES and 2 for NO)"
read nginx5
if [ $nginx5 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /usr/local/etc/nginx $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /var/lib/mysql? (Choose 1 for YES and 2 for NO)"
read nginx6
if [ $nginx6 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/lib/mysql $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /etc/ssl/certs? (Choose 1 for YES and 2 for NO)"
read nginx7
if [ $nginx7 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /etc/ssl/certs $DIR;
	echo "Done backing-up."
fi

echo "Do you want to backup folder /run/nginx.pid? (Choose 1 for YES and 2 for NO)"
read nginx8
if [ $nginx8 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /run/nginx.pid $DIR;
	echo "Done backing-up."
fi


echo "Do you want to backup folder /var/run/nginx.pid? (Choose 1 for YES and 2 for NO)"
read nginx9
if [ $nginx9 -eq 1 ]
then
  echo "Backing up folder..."
	cp -r /var/run/nginx.pid $DIR;
	echo "Done backing-up."
fi
}

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
  rm -r $DIR
	rm server.txt
	rm -r $FILE
  echo -e "${GREEN}Local Backup Has Been Removed\e[0m"
}

cleanlocaltempbackup







