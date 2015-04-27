#!/bin/sh
# Author : JLM
#start boot2docker and container

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

#docker run -td -p 80:80 -p 9000:9000 -v $(pwd)/Sites:/usr/local/apache2/htdocs -v $(pwd)/logs:/usr/local/apache2/logs --name myphp php53apache22
docker run -td -p 80:80 -v $(pwd)/Sites:/var/www/html -v $(pwd)/logs:/var/log/apache2 --name myphp phpsilex

docker run -td -p 3306:3306 -v $(pwd)/db_data:/var/lib/mysql --name mydb db_maria_sql

docker run -td -v $(pwd)/dev:/mnt --name myrvm rvm_maison


docker ps -a
