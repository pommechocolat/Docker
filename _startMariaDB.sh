#!/bin/bash

echo "startup MariaDB / Mysql"

DEBIAN_PASS=$(cat /etc/mysql/debian.cnf | grep password | cut -d\  -f 3 | head -1)
GRANT_ROOT="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$ROOT_DB_PASS' with GRANT OPTION; FLUSH PRIVILEGES;"
GRANT_DEBIAN="GRANT ALL PRIVILEGES ON *.* to 'debian-sys-maint'@'localhost' IDENTIFIED BY '$DEBIAN_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
#l'installation de mariadb prépare par défaut les datas dans /var/lib/mysql !!
if [ ! -f /var/lib/mysql/ibdata1 ]; then
	mysql_install_db
	/usr/bin/mysqld_safe &
	sleep 5s 
  echo $GRANT_ROOT | mysql
  echo $GRANT_DEBIAN | mysql
	killall mysqld
	sleep 5s
fi 

# Lance le serveur mariadb. Cette méthode de lancement conserve la main. On est bien en mode démon
/usr/bin/mysqld_safe
# on autorise root à ce connecter de toute part. On rejout les privilège à chaque fois pour que ça fonctionne sur une installation definie par ailleurs ou l'on ne serait pas passé paur le test ci-dessous.
echo $GRANT_ROOT | mysql
echo $GRANT_DEBIAN | mysql
#/bin/bash