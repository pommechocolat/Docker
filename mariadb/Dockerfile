# Docker file par JLM pour avoir un serveur de base de données

FROM debian:testing
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>
# C'est juste indispensable pour ne pas avoir de souci
ENV DEBIAN_FRONTEND noninteractive
# Vous pouvez ici régler le mot de passe de root pour l'accès aux bases de données
ENV ROOT_DB_PASS root
# Définition de l'utilisateur mysql avant l'installation de mariadb. Les valeurs id et gid correspondent à ceux de l'utilisateur docker.
RUN useradd -u 1000 -g 50 -c "MySQL Server" -d /var/lib/mysql -s /bin/false mysql

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
# Nécessaire pour ne pas avoir deux systèmes de log simultané. Pour le mement pas d'utilisation de syslog
RUN sed -i 's/syslog/\#syslog/g' /etc/mysql/conf.d/mysqld_safe_syslog.cnf
#Docker construit un nouveau conteneur à chaque commande RUN et commit l'image pour le run suivant.
# pour configurer mysql au départ, il faut donc lancer le serveur et faire la config dans le même run
RUN /etc/init.d/mysql start; sleep 5; echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' with GRANT OPTION; GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql
#Cette "foreground command" permet de garder le serveur en mode démon lors d'un run.
#CMD /usr/bin/mysqld_safe
#Insère le fichier _startMariaDB.sh dans le conteneur
ADD ./_startMariaDB.sh /opt/startup.sh
#Il faut avoir les droit en exécution sur le fichier !!
RUN chmod 755 /opt/startup.sh
# Au démarrage du conteneur on lance le script de démarrage de mariadb qui assure le lancement de /usr/bin/mysqld_safe
CMD ["/opt/startup.sh"]
