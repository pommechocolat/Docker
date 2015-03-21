#!/bin/bash

echo "startup MariaDB / Mysql"

DEBIAN_PASS=$(cat /etc/mysql/debian.cnf | grep password | cut -d\  -f 3 | head -1)
GRANT_ROOT="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$ROOT_DB_PASS' with GRANT OPTION; FLUSH PRIVILEGES;"
GRANT_DEBIAN="GRANT ALL PRIVILEGES ON *.* to 'debian-sys-maint'@'localhost' IDENTIFIED BY '$DEBIAN_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
#l'installation de mariadb prépare par défaut les datas dans /var/lib/mysql !!
if [ ! -f /var/lib/mysql/ibdata1 ]; then
	mysql_install_db
	/usr/bin/mysqld_safe &
	sleep 10s
 
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' with GRANT OPTION; GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql
  echo $GRANT_DEBIAN | mysql
	killall mysqld
	sleep 10s
fi 

# Lance le serveur mariadb. Cette méthode de lancement conserve la main. On est bien en mode démon
/usr/bin/mysqld_safe
# on autorise root à ce connecter de toute part
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' with GRANT OPTION; GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql
echo $GRANT_DEBIAN | mysql
