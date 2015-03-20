# Docker
Construction d'images docker pour gérer bases de données, serveur php de différentes version, serveur ruby, etc, pour faire du développement applications web

## Déploiement
### création d'une image
Construction d'une image à partir du Dockerfile présent dans le dossier courant (.). Allec l'option -t elle sera nommé mariadb-jlm avec le tag latest. Ce tag est pris par défaut s'il n'est pas précisé.
'''
docker build -t mariadb-jlm:latest .
'''

Pour vérifier le bon résultat, on peut lister les images é vérifier que celle nommée mariadb-jlm existe bien avec le tag latest.
'''
docker images
'''

### lancement d'un conteneur
Une fois l'image construite, il faut lancer un conteneur. Le -t permet d'avoir un tty afin d'accéder et de visualliser les commande myslq dans le conteneur. Le -d lance le conteneur comme un démon qui ne serêtera donc pas de lui même. On expose le port 3306 avec le -p afin d'accéder à mysql depuis le host. Le conteneur est nommé mydb et il est construit à partir de l'image mariadb-jlm
'''
docker run -d -t -p 3306:3306 --name mydb mariadb-jlm
'''

### pour tout virer avant de recommencer
Pour les tests, tant que le Dockerfile n'est pas bien réglé, il est plus simple et sur de tout remetre à zero à chaque étape. Comme nous avons nommé nos image et conteneur, la liste de commandes suivante va bien :
'''
docker stop mydb; docker rm mydb; docker rmi mariadb-jlm
'''

## Commandes utiles
Pour supprimer tous les conteneurs inactifs :
''' bash
docker rm $(docker ps -a -q)
'''
