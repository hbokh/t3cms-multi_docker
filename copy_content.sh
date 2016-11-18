#!/bin/sh

docker cp typo3:/var/www/html/typo3/fileadmin .
docker cp typo3:/var/www/html/typo3/typo3conf .
#docker cp db:/var/lib/mysql .
