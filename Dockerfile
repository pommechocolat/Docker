# Docker file par JLM pour avoir un serveur de base de données

FROM debian:testing
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>
# C'est juste indispensable pour ne pas avoir de souci
ENV DEBIAN_FRONTEND noninteractive

#pour éviter le message invoke-rc.d: policy-rc.d denied execution of stop
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

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
#Docker construit un nouveau conteneur à chaque commande RUN et commit l'image pour le run suivant.
# pour configurer mysql au départ, il faut donc lancer le serveur et faire la config dans le même run
RUN /etc/init.d/mysql start; sleep 5; echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' with GRANT OPTION; GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql
#Cette "foreground command" permet de garder le serveur en mode démon lors d'un run.
CMD /usr/bin/mysqld_safe