FROM debian

# Set this to the latest TYPO3 CMS version:
#ENV TYPO3_VERSION 6.2.28
ENV TYPO3_VERSION 7.6.12

RUN apt-get update -qq && \
    apt-get install -qqy wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install TYPO3 CMS
RUN mkdir -p /var/www/html/typo3 && \
    cd /var/www/html && \
    wget -O - http://prdownloads.sourceforge.net/typo3/typo3_src-${TYPO3_VERSION}.tar.gz | tar zxf - && \
    cd typo3 && \
    ln -s ../typo3_src-${TYPO3_VERSION} typo3_src && \
    ln -s typo3_src/index.php index.php && \
    ln -s typo3_src/typo3 typo3 && \
    mkdir typo3conf fileadmin && \
    touch /var/www/html/typo3/FIRST_INSTALL && \
    chown -R www-data:www-data /var/www

COPY AdditionalConfiguration.php /var/www/html/typo3/typo3conf/AdditionalConfiguration.php

VOLUME /var/www/html

CMD ["true"]
