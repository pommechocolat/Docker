# Docker file par JLM pour avoir un serveur web avec PHP5.3

FROM ../phpSilexComposer
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>

#Mise en place de xDebug. Ce serait bien de le mettre dans un container (de dev) à part !!
#https://github.com/henrik-farre/docker/blob/master/Dockerfile
RUN apt-get install -y php5-xdebug

RUN echo xdebug.remote_enable=1 >> /etc/php5/conf-available/xdebug.ini
RUN echo xdebug.remote_autostart=0 >> /etc/php5/conf-available/xdebug.ini
RUN echo xdebug.remote_connect_back=1 >> /etc/php5/conf-available/xdebug.ini
RUN echo xdebug.remote_port=9000 >> /etc/php5/conf-available/xdebug.ini
RUN echo xdebug.remote_log=/var/log/apache2/xdebug.php >> /etc/php5/conf-available/xdebug.ini
RUN ln -s /etc/php5/conf-available/xdebug.ini /etc/php5/mods-available/
RUN php5enmod xdebug

RUN echo "<?php phpinfo();" > /var/www/html/info.php

CMD ["/opt/startup.sh"]
