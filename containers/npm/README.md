# Docker jlm/npm
Cette image met en place npm qui installe aussi nodejs avec un lien symbolique pour avoir node :
```
docker build -t jlm/npm .
```

Pour construire un conteneur en mode interactif avec l'éventualité d'un serveur web répondant sur le port 8080 avec une redirection de port pour utiliser sur l'hôst le port 8099 (8080 étant pris par tomcat java / nuxéo) la commande sera :
```
docker run -ti -p 8099:8080 --name mynpm jlm/npm
```

Pour saisir ce fichier dans le docker, il suffit de faire un 
```
cat > serveur.js
```
puis de coller le texte puis de faire ctrl-D. Le fichier est enregistrée. Pour lancer le serveur nodejs serveur.js. Du coup il suffit aller dans un navigateur avec l'[URL](http://192.168.99.100:8099) pour voir le message transmi


## Installation de npm
Les fichiers .js sont placés dans quelques dossiers à savoir :
/usr /lib   /nodejs avec des liens symbolique vers node-gyp et npm
     /share /doc
            /node-gyp
            /javascript qui contient jQuery
            /npm  /lib
                  /node_modules
# Exemples du cours JS d'OpenClassRooms :

1erApp : https://openclassrooms.com/courses/des-applications-ultra-rapides-avec-node-js/une-premiere-application-avec-node-js

2Event : https://openclassrooms.com/courses/des-applications-ultra-rapides-avec-node-js

3Module => https://www.npmjs.com




