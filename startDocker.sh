#!/bin/sh
# Author : JLM
#start boot2docker and container

cdata=$(pwd)/../cdata

if [[ $# -eq 1 ]];then
  cdata=$1
fi
echo $cdata

#start booot2docker
#boot2docker up

cd php5.3
docker build -t php53apache22 .
cd ../php5.4
docker build -t php54apache22 .
cd ../phpSilexComposer
docker build -t phpsilex .
cd ../mariadb
docker build -t db_maria_sql .
cd ../rubyRvm
docker build -t rvm_maison .
cd ..

docker images

docker run -td -p 8053:80 -v "$cdata/Sites53":/usr/local/apache2/htdocs -v "$cdata/logs":/usr/local/apache2/logs --name myphp53 php53apache22
docker run -td -p 8054:80 -v "$cdata/Sites53":/usr/local/apache2/htdocs -v "$cdata/logs":/usr/local/apache2/logs --name myphp54 php54apache22
#docker run -td -p 8111:80 -p 9000:9000 -v "$cdata/sitesphp53":/usr/local/apache2/htdocs -v "$cdata/logs":/usr/local/apache2/logs --name my53 php53apache22
docker run -td -p 8010:80 -v "$cdata/Sites":/var/www/html -v "$cdata/logs":/var/log/apache2 -v "$cdata/siteEnable":/etc/apache2/sites-enabled --name myphp phpsilex

ln -s /etc/apache2/sites-available/000-default.conf "$cdata/siteEnable/"

docker run -td -p 3306:3306 -v "$cdata/db_data":/var/lib/mysql --name mydb db_maria_sql

docker run -td -p 35729:35729 -v "$cdata":/mnt --name myrvm rvm_maison


docker ps -a
