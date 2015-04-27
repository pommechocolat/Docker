# Docker
Construction d'images docker pour gérer bases de données, serveur php de différentes version, serveur ruby, etc, pour faire du développement applications web

## Mariadb
L'installation de MariaDB est assez direct lorsque les data sont embarquée dans le conteneur. Seulement ces data ne sont pas perrenes !!
La solution souvent proposés consiste à monter un deuxième conteneur possédant les data... Pas si intéressant que ça ; c'est l'installation docker qui doit tout posséder. Seulement sur OSX ou sur Window docker est dans une VM virtualbox... c'est pas terrible non plus.

La solution donc est d'aller sur le host... mais là les choses se compliquent pour la gestion des droits d'accès !

Une solution consiste à définir au préalable l'utilisateur mysql avec les bon id et gid ! Mais lesquels. Docker est l'application qui tourne en dessous des conteneurs. C'est dont les id et gid de docker qu'il faut prendre en compte. boot2docker ssh permet de se connecter à la VM docker. la commande id donne alors les valeurs à placer dans la commande useradd -u ID_DOCKER -g GID_DOCKER.

### création d'une image
Construction d'une image à partir du Dockerfile présent dans le dossier courant (.). Avec l'option -t elle sera nommé mariadb-jlm avec le tag latest. Ce tag est pris par défaut s'il n'est pas précisé.
```
docker build -t db_maria_sql .
```

Pour vérifier le bon résultat, on peut lister les images é vérifier que celle nommée mariadb-jlm existe bien avec le tag latest.
```
docker images
```

### lancement d'un conteneur
Une fois l'image construite, il faut lancer un conteneur. Le -t permet d'avoir un tty afin d'accéder et de visualliser les commande myslq dans le conteneur. Le -d lance le conteneur comme un démon qui ne serêtera donc pas de lui même. On expose le port 3306 avec le -p afin d'accéder à mysql depuis le host. Le conteneur est nommé mydb et il est construit à partir de l'image mariadb-jlm
```
docker run -dt -p 3306:3306 --name mydb db_maria_sql
```

Si l'on veut travailler avec une persistance des data sur le host... voici la méthode pour lancer le conteneur. Il faut attendre quelques seconde la première fois car il fait installer les tables et placer les privilèges une première fois. 
``` bash
docker run -dt -p 3306:3306 --name mydb -v /host/path/to/mysql_data:/var/lib/mysql db_maria_sql
```

### pour tout virer avant de recommencer
Pour les tests, tant que le Dockerfile n'est pas bien réglé, il est plus simple et sûr de tout remetre à zero à chaque étape. Comme nous avons nommé nos image et conteneur, la liste de commandes suivante va bien :
```
docker stop mydb; docker rm mydb; docker rmi db_maria_sql
```

## Php5.3
Pour construire l'image Php53, il suffit de se placer dans le dossier php5.3 et de lancer la commande :

```
docker build -t php53apache22 .
```
La commande peut être lancée plusieurs fois en modifiant le docker file. La nouvelle image prendra le nom, l'ancienne sera dénommé (<none>).
  
Le lanement du serveur Apache 2.2/Php5.3 se fait à l'aide la commande :
```
docker run -td -p 80:80 -v /host/path/to/www_data:/usr/local/apache2/htdocs --name php53 php53apache22
```
-p 80:80 permet de transport du port de communicartion http vers l'extérieur
 
## PhpSilex
Pour construire l'image phpSilex
```
docker build -t phpsilex .
```
Le lanement du serveur Apache/PHP se fait à l'aide la commande :
```
docker run -d -p 80:80 -v $(pwd)/Sites:/usr/local/apache2/htdocs  -v $(pwd)/logs:/usr/local/apache2/logs --name myphp phpsilex
```

## RVM / Ruby
Pour construire l'image RVM, il suffit de se placer dans le dossier RVM et de lancer la commande :
```
docker build -t rvm_maison .
```
On se moque pas mal de l'alerte concernant l'utilisation de RVM en tant que root car on est uniquement en root. Ceci dit pour travailler sur les fichiers de host ce n'est peut-être pas la panacée ?
```
docker run -td -v /host/path/to/sourceSassGuard:/mnt --name myrvm rvm_maison
```

Nous avons une machine à même de nous permettre de travailler avec les outils ruby. En se connectant sur la machine, il est possible de lancer des outils comme bundler si l'on possède un fichier Gemfile contenant les modules ruby nécessaire au projet.

```
docker-enter myrvm
cd /mnt
. /usr/local/rvm/scripts/rvm
bundle install 
```

Ensuite on peu lancer guard pour recompiler les fichiers sur chaque modification. Cependant les fichiers modifiés dans /host/path/to/sourceSassGuard ne sont pas pris en compte... on est pas sur le même système. Il faut donc monter le dossier /mnt de la VM dans le Finder via sshfs après avoir installé sur OSX les outils OSxFuse et sshfs à l'aide de brew (https://github.com/osxfuse/osxfuse/wiki/SSHFS) :
```
mkdir /Volumes/fuse
sshfs docker@192.168.59.103:/ /Volumes/fuse -ocache=no -onolocalcaches -ovolname=ssh
```

Le mot de passe de docker dans boot2docker est tcuser. Une fois connecté ainsi, les fichiers modifée dans /mnt sont reconnus comme tel par guard qui relance la compilation.

## Commandes utiles
Pour supprimer tous les conteneurs (inactifs!) :
``` bash
docker rm $(docker ps -a -q)
```

Suppresion de tous les conteneurs arrêtés
```
docker rm $(docker ps -a | grep "Exited" | cut -d \  -f1)
```

Suppression de toutes les images non nommées
```
docker rmi $(docker images | grep '<none>' | sed 's/  */:/g' | cut -d: -f3)
```

## Redirection de port
L'accès au host via l'url de boot2docker ne pose aucun problème.
Il est possible d'attaquer boot2docker par localhost à la condition d'utiliser un port au delà de 1000 (exemple 8080) en configurant la VM dans Virtualbox avec une ligne de redirection de port de type : "docker,127.0.0.1, 8080, ,80". On peu aussi le faire à la ligne de commande avec la formule suivnate : 
```
VBoxManage controlvm boot2docker-vm natpf1 "docker,tcp,127.0.0.1,8080,,80"
```

# Lancment des VM Docker
## PHP53
```
docker run -td -p 80:80 -p 9000:9000 -v $(pwd)/Sites:/usr/local/apache2/htdocs -v $(pwd)logs:/usr/local/apache2/logs --name myphp53 php53apache22
```
### Options possibles
--name myphp53

## MariaDb
```
docker run -td -p 3306:3306 -v $(pwd)/db_data:/var/lib/mysql --name mydb db_maria_sql
```
### Options possibles
--name mydb

## Rvm
```
docker run -td -v $(pwd)/rubyRvm:/mnt --name myrvm rvm_maison
```

## PhpSilex
```
docker run -td -p 80:80 -v $(pwd)/Sites:/var/www/html -v $(pwd)/logsApache:/usr/local/apache2/logs --name myphp phpSilex
```

