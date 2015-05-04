#!/bin/sh
# Author : JLM
#start boot2docker and container

vmdata=$(pwd)/../vmdata

if [[ $# -eq 1 ]];then
  vmdata=$1
fi
echo $vmdata

#start booot2docker
boot2docker up

cd php5.3
docker build -t php53apache22 .
cd ../phpSilexComposer
docker build -t phpsilex .
cd ../mariadb
docker build -t db_maria_sql .
cd ../rubyRvm
docker build -t rvm_maison .
cd ..

docker images

docker run -td -p 80:80 -p 9000:9000 -v "$vmdata/Sites53":/usr/local/apache2/htdocs -v "$vmdata/logs":/usr/local/apache2/logs --name myphp53 php53apache22
docker run -td -p 8010:80 -v "$vmdata/Sites":/var/www/html -v "$vmdata/logs":/var/log/apache2 -v "$vmdata/siteEnable":/etc/apache2/sites-enabled --name myphp phpsilex

ln -s /etc/apache2/sites-available/000-default.conf "$vmdata/siteEnable/"

docker run -td -p 3306:3306 -v "$vmdata/db_data":/var/lib/mysql --name mydb db_maria_sql

docker run -td -v "$vmdata":/mnt --name myrvm rvm_maison


docker ps -a
