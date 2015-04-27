#!/bin/sh
# Author : JLM
#stop everythings in boot2docker

docker ps -a

#on arrête les conteneurs
docker stop myphp53
docker stop myphp
docker stop mydb
docker stop myrvm
#supprime tous les conteneur exited
docker rm $(docker ps -a | grep "Exited" | cut -d \  -f1)

docker ps -a
#stop booot2docker
boot2docker down
