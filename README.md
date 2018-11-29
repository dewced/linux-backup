# Linux Backup Script
Linux-Backup

What to backup:

## Apache

### Ubuntu:
- /var/www
- /etc/httpd
- /var/lib/mysql
- /etc/ssl/certs voor de certificaten
- /run/httpd
- /var/run/httpd

### Debian:

- /var/www
- /etc/apache2
- /var/lib/mysql
- /etc/ssl/certs voor de certificaten
- /run/apache2
- /var/run/apache2

## Nginx

### Ubuntu
- /usr/share/nginx
- /etc/nginx en als het daar niet staat onder /usr/local/nginx/conf of /usr/local/etc/nginx
- /var/lib/mysql
- /etc/ssl/certs voor de certificaten
- /run/nginx.pid
- /var/run/nginx.pid

### Debian

- /usr/share/nginx
- /etc/nginx en als het daar niet staat onder /usr/local/nginx/conf of /usr/local/etc/nginx
- /var/lib/mysql
- /etc/ssl/certs voor de certificaten
- /run/nginx.pid
- /var/run/nginx.pid

## TestVPS
Droplet Name: ubuntu-s-1vcpu-1gb-ams3-01
IP Address: 188.166.12.77
Username: root
Password: linuxbackup1819

#### Rolverdeling

- Kwinten: testen backupscript
- Cedric: Verder werken aan script
- Sam: zien welke mapjes bij elke service belangrijk zijn om te backuppen
