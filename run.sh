#!/bin/bash
set -e

PACKAGEPREFIX='php54w-'

if [ ! -f "/started" ]
then
	touch '/started'	

	if [ ! "$WEBROOT" ]
	then
		WEBROOT=''
	fi

	sed 's/{webroot}/\/'$WEBROOT'/g' httpd.conf > /etc/httpd/conf/httpd.conf

	if [ "$PHPPACKAGE" ]
	then
		FULLPACKAGE=''
		for ITEM in $PHPPACKAGE
		do FULLPACKAGE=$PACKAGEPREFIX''$ITEM' '$FULLPACKAGE
		done
		yum -y install $FULLPACKAGE
	fi

	if [ "$PACKAGE" ]
	then
		yum -y install $PACKAGE
	fi

	for ITEM in "$@"
	do parts=($(echo $ITEM | tr "=" "\t"))
	echo "$ITEM" > /tmp/item
	sed 's/\\/\\\\/g' /tmp/item >/tmp/item2
	mv /tmp/item2 /tmp/item
	sed 's/\//\\\//g' /tmp/item >/tmp/item2
	mv /tmp/item2 /tmp/item

	ITEM=`cat /tmp/item`
	PATTERN='s/\(^\|;\)'${parts[0]}' =.*/'$ITEM'/'
	sed "$PATTERN" /etc/php.ini > /tmp/php.ini
	mv /tmp/php.ini /etc/php.ini
	done

fi

rm -rf /run/httpd/* /tmp/httpd*
exec /usr/sbin/apachectl -DFOREGROUND