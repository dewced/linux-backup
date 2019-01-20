# Linux Backup Script for backup to FTP/SFTP server!

**This is a backup script for Linux that can back up an entire webserver and uploads the back-up to a FTP server. You can choose to do a full back-up at once or choose the different folders.**

_*** If you get an Not Connected error at the end. That means that the FTP Credentials you entered are wrong. ***_

# Which folders are backed up?
## Ubuntu

### Apache:


- /var/www/
- /etc/httpd/
- /var/lib/mysql/
- /etc/ssl/certs/ voor de certificaten
- /run/httpd/
- /var/run/httpd/

### Nginx:

- /usr/share/nginx/
- /etc/nginx/ en als het daar niet staat onder /usr/local/nginx/conf/ of /usr/local/etc/nginx/
- /var/lib/mysql/
- /etc/ssl/certs/ voor de certificaten
- /run/nginx.pid
- /var/run/nginx.pid
## Debian

### Apache:

- /var/www/
- /etc/apache2/
- /var/lib/mysql/
- /etc/ssl/certs/ voor de certificaten
- /run/apache2/
- /var/run/apache2/

### Nginx:

- /usr/share/nginx/
- /etc/nginx/ en als het daar niet staat onder /usr/local/nginx/conf/ of /usr/local/etc/nginx/
- /var/lib/mysql/
- /etc/ssl/certs/ voor de certificaten
- /run/nginx.pid
- /var/run/nginx.pid

## CentOS

### Apache:

- /etc/httpd/conf.d/
- /var/www/
- /etc/httpd/conf/
- /etc/ssl/certs/ voor de certificaten
- /run/httpd/
- /var/run/httpd/

### Nginx:

- /etc/nginx/
- /etc/nginx/nginx.conf
- /usr/share/nginx/html/
- /etc/nginx/conf.d/default.conf
- /etc/nginx/conf.d/

*Support*

You can contact us directly on support[AT]cedricdewitte.be
