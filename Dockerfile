# Docker file par JLM pour avoir un serveur de base de données

FROM debian:testing
MAINTAINER jlm
# C'est juste indispensable pour ne pas avoir de souci
ENV DEBIAN_FRONTEND noninteractive

# La liste des paquets disponible doit être mise à jour pour pouvoir travailler
RUN apt-get update > /dev/null
#RUN apt-get -y upgrade 
# Pas certain d'avoir besoin de ça... mais comme y a une erreur... tentative de correction
RUN apt-get -y install apt-utils > /dev/null
# Prépa de la configuration de maria DB et installation. Il prépare de suite un espace de data dans /var/lib/mysql
RUN echo mariadb-server-5.5 mariadb-server/root_password password root | debconf-set-selections
RUN echo mariadb-server-5.5 mariadb-server/root_password_again password root | debconf-set-selections
RUN apt-get -y install mariadb-server > /dev/null
# Autorisation d'interrogation depuis n'importe où (donc depuis le host)
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf

#Insère le fichier _startMariaDB.sh dans le conteneur
ADD ./_startMariaDB.sh /opt/startup.sh
#Il faut avoir les droit en exécution sur le fichier !!
RUN chmod 755 /opt/startup.sh

EXPOSE 3306

# Au démarrage du conteneur on lance le script de démarrage de mariadb
CMD ["/opt/startup.sh"]
