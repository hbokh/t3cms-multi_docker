#!/bin/sh

# NAME = PWD used in compose, depending on directory name:
NAME="t3cmsmultidocker"
#NAME=typo3cms

docker cp $NAME\_web_1:/var/www/html/typo3/fileadmin .
docker cp $NAME\_web_1:/var/www/html/typo3/typo3conf .
docker cp $NAME\_db_1:/var/lib/mysql .
