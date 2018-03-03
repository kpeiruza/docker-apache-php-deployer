#!/bin/bash

DOCROOT="/var/www/html"
APACHEUSER="www-data"

if [ -z "$URL" ]
then
	echo "Bad usage, please provide the 'URL' environment variable"
	exit 64
fi

cd $DOCROOT
rm -fr *

#	Download file
wget -q --no-check-certificate "$URL"
filename=$(ls)

#	Uncompress file
if [ $(file $filename | grep -c "Zip archive data") -eq 1 ]
then
	unzip $filename
else
	tar xf $filename
fi

rm $filename

#	Move subfolders if necessary
if [ $(ls | wc -l) -eq 1 ]
then
	subfolder=$(ls)
	mv $subfolder/* $subfolder/.* . 2>/dev/null
	rmdir $subfolder
fi
chown -R $APACHEUSER: .

/usr/sbin/apachectl -D FOREGROUND
