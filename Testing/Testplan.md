# Linux backup script testplan

De zaken die getest gaan worden voor dit backup-script:

- Wordt alles gebackupped naar de FTP server vanaf een CentOS besturingssysteem plus zijn dit de mapjes die benodigd zijn voor dit besturingssysteem. 

Voor CentOS zijn dit voor Apache: /etc/httpd/conf.d/, /var/www/, /etc/httpd/conf/, /etc/ssl/certs voor de certificaten, /run/httpd en /var/run/httpd. Voor Nginx zijn dit: /etc/nginx/, /etc/nginx/nginx.conf, /usr/share/nginx/html/, /etc/nginx/conf.d/default.conf en /etc/nginx/conf.d/

- Wordt alles gebackupped naar de FTP server vanaf een Debian besturingssysteem plus zijn dit de mapjes die benodigd zijn voor dit besturingssysteem.

Voor Debian zijn dit voor Apache: /var/www/, /etc/apache2/, /var/lib/mysql/, /etc/ssl/certs/ voor de certificaten, /run/apache2/ en /var/run/apache2/. Voor Nginx zijn dit: /usr/share/nginx/, /etc/nginx/ en als het daar niet staat onder /usr/local/nginx/conf/ of /usr/local/etc/nginx/, /var/lib/mysql/, /etc/ssl/certs/, /run/nginx.pid en /var/run/nginx.pid.

- Wordt alles gebackupped naar de FTP server vanaf een Ubuntu besturingssysteem plus zijn dit de mapjes die benodigd zijn voor dit besturingssysteem.

Voor Ubunto zijn dit voor Apache: /var/www/, /etc/httpd/, /var/lib/mysql/, /etc/ssl/certs/, /run/httpd/ en /var/run/httpd/. Voor Nginx zijn dit: /usr/share/nginx/, /etc/nginx/ en als het daar niet staat onder /usr/local/nginx/conf/ of /usr/local/etc/nginx/, /var/lib/mysql/, /etc/ssl/certs/, /run/nginx.pid en /var/run/nginx.pid.

## Test plan

### Ubuntu | CentOS | Debian


1. Van zodra je je op dit hostsysteem bevindt, ga je naar de terminal.
2. Je zorgt ervoor dat het `backupscript.sh` zich bevindt onder /home. 
3. Voor je het script gaat uitvoeren, ga je in dit script en geef je de info in voor de FTP server zoals username, wachtwoord, server IP en de poort.
4. Je begeeft je naar de /home directory en voert het backupscript uit door het commando: `sudo backupscript.sh`.
5. Van zodra je dit hebt gedaan wordt het hostsysteem geëvalueerd en wordt bekeken wel OS dit is. Het geeft dan ook de vraag welke mapjes je zou willen backuppen.
6. Om nu te checken of dit wel degelijk goed gedaan is, gaan we in de FTP server en unzippen we deze zip en kijken we of alles hier in zit.

Dezelfde stappen gelden voor de verschillende besturingssystemen.
