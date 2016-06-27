FROM php:7-apache
MAINTAINER jlmunivlorraine <jean-luc.metzger@univ-lorraine.fr>

ENV VERSION=omeka-2.4.1
ENV TEMPLATE_SETTINGS=db.ini.template
ENV SETTINGS=db.ini

ENV MYSQL_HOST=db
ENV MYSQL_USERNAME=omeka
ENV MYSQL_PASSWORD=omeka
ENV MYSQL_DATABASE=omeka
ENV MYSQL_PORT=3306

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install exif

RUN curl --location http://omeka.org/files/$VERSION.zip > omeka.zip
RUN apt-get update
RUN apt-get install unzip
RUN unzip omeka.zip
RUN chown -R www-data:www-data ${VERSION}

RUN mv ${VERSION}/${SETTINGS} ${VERSION}/${SETTINGS}.initial
RUN cp ${VERSION}/.htaccess ${VERSION}/htaccess.initial 
RUN echo "[database]" > ${VERSION}/${TEMPLATE_SETTINGS}
RUN echo "host=<%= @MYSQL_HOST %>" >> ${VERSION}/${TEMPLATE_SETTINGS}
RUN echo "username=<%= @MYSQL_USERNAME %>" >> ${VERSION}/${TEMPLATE_SETTINGS}
RUN echo "password=<%= @MYSQL_PASSWORD %>" >> ${VERSION}/${TEMPLATE_SETTINGS}
RUN echo "dbname=<%= @MYSQL_DATABASE %>" >> ${VERSION}/${TEMPLATE_SETTINGS}
RUN echo " " >> ${VERSION}/${TEMPLATE_SETTINGS}

RUN eval "cat << $(sed 's/[\$`]/\\&/g;s/<%= @\([^ ]*\) %>/${\1}/g' < ${VERSION}/${TEMPLATE_SETTINGS})" > ${VERSION}/${SETTINGS}.tmp

RUN (echo "[database]" ; cat ${VERSION}/${SETTINGS}.tmp) > ${VERSION}/${SETTINGS}
RUN rm ${VERSION}/${SETTINGS}.tmp
RUN rm ${VERSION}/${TEMPLATE_SETTINGS}
RUN rm omeka.zip

WORKDIR /etc/apache2/mods-enabled
RUN ln -s ../mods-available/rewrite.load .
 
RUN apt-get clean
WORKDIR /var/log
RUN rm -rf apt alternatives.log bootstrap.log btmp dmesg dpkg.log fsck wtmp faillog lastlog

WORKDIR /var/www/html/

RUN echo "<h1>Bienvenue</h1><a href='info.php'>phpInfo()</a><br/><a href='${VERSION}'>${VERSION}</a>" > /var/www/html/index.html
RUN echo "<?php phpinfo();" > /var/www/html/info.php
RUN env
