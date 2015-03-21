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
docker build -t my_mariadb:latest .
```

Pour vérifier le bon résultat, on peut lister les images é vérifier que celle nommée mariadb-jlm existe bien avec le tag latest.
```
docker images
```

### lancement d'un conteneur
Une fois l'image construite, il faut lancer un conteneur. Le -t permet d'avoir un tty afin d'accéder et de visualliser les commande myslq dans le conteneur. Le -d lance le conteneur comme un démon qui ne serêtera donc pas de lui même. On expose le port 3306 avec le -p afin d'accéder à mysql depuis le host. Le conteneur est nommé mydb et il est construit à partir de l'image mariadb-jlm
```
docker run -dt -p 3306:3306 --name mydb my_mariadb
```

Si l'on veut travailler avec une persistance des data sur le host... voici la méthode pour lancer le conteneur. Il faut attendre quelques seconde la première fois car il fait installer les tables et placer les privilèges une première fois. 
``` bash
docker run -dt -p 3306:3306 --name mydb -v /host/path/to/mysql_data:/var/lib/mysql my_mariadb
```

### pour tout virer avant de recommencer
Pour les tests, tant que le Dockerfile n'est pas bien réglé, il est plus simple et sûr de tout remetre à zero à chaque étape. Comme nous avons nommé nos image et conteneur, la liste de commandes suivante va bien :
```
docker stop mydb; docker rm mydb; docker rmi my_mariadb
```

### Preparation Dockerfile pour mariadb


## Commandes utiles
Pour supprimer tous les conteneurs (inactifs!) :
``` bash
docker rm $(docker ps -a -q)
```
