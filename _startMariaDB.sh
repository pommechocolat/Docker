#/bin/bash

echo "startup MariaDB / Mysql"

#l'installation de mariadb prépare par défaut les datas dans /var/lib/mysql !!
#if [ ! -f /var/lib/mysql/ibdata1 ]; then
#	mysql_install_db
#	/usr/bin/mysqld_safe &
#	sleep 10s
# 
#	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' with GRANT OPTION; GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql
#	killall mysqld
#	sleep 10s
#fi 

#Lance le serveur mariadb
service mysql start
#attend 2 secondes
sleep 2
# on autorise root à ce connecter de toute part
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' with GRANT OPTION; GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql
