# TYPO3 CMS 6.x multi container setup

TYPO3 CMS in 4 separate containers (microservice-like):

- **php**: runs PHP-FPM v5.6
- **web**: runs nginx v1.9.x
- **db**: runs MySQL database v5.5
- **typo3**: data-only volume container with TYPO3 distribution

### Install

Install in a directory named "typo3cms" (so rename this one).

### Reuse of generated content and config on Linux

After the first installation, it is useful to have the generated configuration and content back in place. To do this, run these commands to copy the contents from within the (running!) container to the local filesystem:

```
docker cp typo3cms_web_1:/var/www/html/typo3/fileadmin .
docker cp typo3cms_web_1:/var/www/html/typo3/typo3conf .
docker cp typo3cms_db_1:/var/lib/mysql .
```

After this, also uncomment the corresponding lines in `docker-compose.yml`.  
Start the stack with `docker-compose up --no-recreate`.

**NOTE** The volume-mount for MySQL is not working with boot2docker!

## Issues

###TYPO3 error

TYPO3 gives this error after installation:  

![image](https://github.com/hbokh/docker-typo3-cms/raw/master/TYPO3_error.png)

This is related to [TYPO3-CORE-SA-2014-001: Multiple Vulnerabilities in TYPO3 CMS](http://typo3.org/teams/security/security-bulletins/typo3-core/typo3-core-sa-2014-001/).

A fix is to login into the container and add a line to the file

 `/var/www/site/htdocs/typo3conf/LocalConfiguration.php`

using *docker exec* (introduced in Docker v1.3):  `$ docker exec -it <container ID> bash`  

```
$ docker exec -ti typo3cms_web_1 bash
root@01c255c6173d:/# vi /var/www/site/htdocs/typo3conf/LocalConfiguration.php
```

At the bottom of the file, within the SYS-array, add this line containing the *trustedHostsPattern*:

	'SYS' => array(
                [ ... ],
		'trustedHostsPattern' => '.*',
	),

This is somewhat of a showstopper to use the container straight away, but is only needed the first time.

## Extra

**Exensions available**

You are limited to the use of these PHP5 extensions in Debian:

```
Possible values for ext-name:
bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json ldap mbstring mcrypt mssql mysql mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard sybase_ct sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip
```

So php5-imagick (which is available on Ubuntu) is no option as of yet...

**References**

[Docker: Nginx and php5-fpm dockers are not talking](http://stackoverflow.com/questions/27055627/docker-nginx-and-php5-fpm-dockers-are-not-talking) (Serverfault.com)

---
hbokh, July 2015
