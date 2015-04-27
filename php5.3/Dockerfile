# Docker file par JLM pour avoir un serveur web avec PHP5.3

FROM debian:testing
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>
# C'est juste indispensable pour ne pas avoir de souci
ENV DEBIAN_FRONTEND noninteractive
# Définition de l'utilisateur apache avant l'installation de Apache. Les valeurs id et gid correspondent à ceux de l'utilisateur docker.
RUN useradd -u 1000 -g 50 -c "Apache Server" -d /usr/local/apache2 -s /bin/false apache
#pour éviter le message invoke-rc.d: policy-rc.d denied execution of stop
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN apt-get update > /dev/null
# Pas certain d'avoir besoin de ça... mais comme y a une erreur... tentative de correction
RUN apt-get -y install apt-utils > /dev/null
RUN apt-get -y upgrade > /dev/null

# Outils nécessaires à la compilation de php5.3 et apache2.2
RUN apt-get -y install wget > /dev/null
RUN apt-get -y install bzip2 > /dev/null
RUN apt-get -y install gcc > /dev/null
RUN apt-get -y install libxml2-dev > /dev/null
RUN apt-get -y install make > /dev/null

# Nécessaire pour la compilation de PHP avec MySQL
RUN apt-get -y install libmysqlclient-dev > /dev/null
RUN apt-get -y install libmcrypt-dev > /dev/null
RUN apt-get -y install libcurl4-gnutls-dev > /dev/null

# Installation de apache2.2
WORKDIR /root
RUN wget http://apache.crihan.fr/dist//httpd/httpd-2.2.29.tar.gz 
RUN tar -xf httpd-2.2.29.tar.gz
WORKDIR /root/httpd-2.2.29
RUN ./configure --enable-so --enable-rewrite=shared > /dev/null
RUN make > /dev/null
RUN make install > /dev/null
RUN echo "application/x-httpd-php php phtml php4" >> /usr/local/apache2/conf/mime.types

# Installation de php5.3
WORKDIR /root
RUN wget http://in1.php.net/distributions/php-5.3.29.tar.bz2
RUN tar -xf php-5.3.29.tar.bz2 > /dev/null
WORKDIR /root/php-5.3.29
RUN ./configure --with-apxs2=/usr/local/apache2/bin/apxs --with-mysql --with-mysqli --with-curl=shared,/usr --with-mcrypt=shared,/usr
RUN make > /dev/null
#RUN make test
RUN make install > /dev/null
RUN echo "extension=curl.so\nextension=mcrypt.so" >> /usr/local/lib/php.ini

# Installation de Xdebug en version compatible PHP5.3
WORKDIR /root
RUN apt-get -y install autoconf
RUN wget http://xdebug.org/files/xdebug-2.2.7.tgz
RUN tar -xzf xdebug-2.2.7.tgz > /dev/null
WORKDIR /root/xdebug-2.2.7
RUN phpize
RUN ./configure --enable-xdebug
RUN make
RUN make install
# Configuration de php.ini. RQ : le nom de la machine (remote_host) est sans doute à modifier
RUN echo "[Xdebug]\nzend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20090626/xdebug.so\nxdebug.remote_enable=1\nxdebug.remote_host=localhost\nxdebug.remote_port=9000\nxdebug.show_local_vars=1" >> /usr/local/lib/php.ini
RUN php --version

RUN sed -i 's/User daemon/User apache/g' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's/Group daemon/Group staff/g' /usr/local/apache2/conf/httpd.conf
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf

RUN echo "<?php phpinfo(); " > /usr/local/apache2/htdocs/info.php

ENTRYPOINT /usr/local/apache2/bin/httpd -D FOREGROUND
#CMD ["/usr/local/apache2/bin/apachectl", "start"]