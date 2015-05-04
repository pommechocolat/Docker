# Docker file par JLM pour avoir un serveur web avec PHP5.3

FROM debian:testing
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>
# C'est juste indispensable pour ne pas avoir de souci
ENV DEBIAN_FRONTEND noninteractive

RUN useradd -u 1000 -g 50 -c "Apache Server" -d /var/www -s /usr/sbin/nologin apache

# Pour éviter le message invoke-rc.d: policy-rc.d denied execution of stop
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN apt-get update > /dev/null
# Pas certain d'avoir besoin de ça... mais comme y a une erreur... tentative de correction
RUN apt-get -y install apt-utils > /dev/null
RUN apt-get -y upgrade > /dev/null

# PHP5 install aussi apapche2
RUN apt-get -y install php5 > /dev/null
RUN apt-get install -y php5-mysql > /dev/null
RUN echo "<?php phpinfo();" > /var/www/html/info.php

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=apache/g' /etc/apache2/envvars
RUN sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=staff/g' /etc/apache2/envvars


#ENTRYPOINT /usr/sbin/apache2ctl -D FOREGROUND
#Insère le fichier _startApache.sh dans le conteneur
ADD ./_startApache.sh /opt/startup.sh
#Il faut avoir les droit en exécution sur le fichier !!
RUN chmod 755 /opt/startup.sh
CMD ["/opt/startup.sh"]
