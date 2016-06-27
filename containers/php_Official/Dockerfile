FROM php:7-apache
MAINTAINER jean-luc.metzger <jean-luc.metzger@univ-lorraine.fr>

#Ajoute composer, nodeJS et less à l'image php officiel de base.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer
RUN apt-get update
RUN apt-get install -y node-less
ENV APACHE_LOG_DIR='/var/log/apache2'
RUN echo "<h1>Bienvenue</h1><a href='info.php'>phpInfo()</a>" > /var/www/html/index.html
RUN echo "<?php phpinfo();" > /var/www/html/info.php
