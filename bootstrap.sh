#!/bin/bash
#	List of supported variables:
#	URL to download, git, tar or zip files.
#	SERVERNAME to configure to apache (for logging purposes)
#	CAT /path/to/create=multiline\ncontent\t\n
#	PREEXEC with raw commands to pass to bash

DOCROOT="/var/www/html"
APACHEUSER="www-data"

. /functions.sh

if [ -z "$URL" ]
then
	echo "Bad usage, please provide the 'URL' environment variable"
	exit 64
fi

cd $DOCROOT
rm -fr *

if [ "$(echo $URL| grep -c '^git=')" -eq 1 ]
then
	
	gitdeploy "$(echo $URL| sed 's/^git.//')"
else
	unpack "$URL"
fi

#	Move subfolders if necessary
if [ $(ls | wc -l) -eq 1 ]
then
	subfolder=$(ls)
	mv $subfolder/* $subfolder/.* . 2>/dev/null
	rmdir $subfolder
fi
chown -R $APACHEUSER: .
#	Start Webserver
if [ -z "$SERVERNAME" ]
then
	SERVERNAME="$(hostname --fqdn)"
fi

echo "ServerName $SERVERNAME" > /etc/apache2/conf-enabled/servername.conf
echo "$PREEXEC" | bash
/usr/sbin/apachectl -D FOREGROUND
