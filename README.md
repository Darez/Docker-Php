# Docker-Php
=================
Dockerfile for httpd server with php.

Getting Started
---------------

You can build this container (php last version) from Github via

	docker build -t php github.com/Darez/Docker-Php

Or build with another php version:

	docker build -t php github.com/Darez/Docker-Php#<version> (e.g 5.4)

To run the container you can do the following:

	docker run -d -p <forwarded port>:80 --privileged -v `pwd`:/var/www/html -i -t php

If u need set webroot or install extra package, use -e with vars:

	WEBROOT='web' #default empty

	PHPPACKAGE='gd mysql' #only package name without prefix (e.g php-gd)

	PACKAGE='vim' #another package with full name

If u need change php.ini config then use args docker:

	php_config=value e.g 'date.timezone=Europe\Warsaw'
e.g:

	docker run -d -e WEBROOT='db_name' -e PHPPACKAGE='gd' -e PACKAGE='vim' -p <forwarded port>:80 --privileged -v `pwd`:/var/www/html -i -t php 'date.timezone=Europe\Warsaw'


