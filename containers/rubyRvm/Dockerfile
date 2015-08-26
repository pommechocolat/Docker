# Docker file par JLM pour avoir un serveur web avec PHP5.3

FROM debian:testing
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>
# C'est juste indispensable pour ne pas avoir de souci
ENV DEBIAN_FRONTEND noninteractive

# Définition de l'utilisateur rvmuser pour ne pas fonctionner en root avec rvm. Les valeurs id et gid correspondent à ceux de l'utilisateur docker.
#RUN useradd -u 1000 -g 50 -c "utilisateur rvm" -d /home/rvmuser -s /bin/bash -m -k /etc/skel/ rvmuser

#pour éviter le message invoke-rc.d: policy-rc.d denied execution of stop
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN apt-get update -q > /dev/null
# Pas certain d'avoir besoin de ça... mais comme y a une erreur... tentative de correction
#RUN apt-get install -qy apt-utils

# On le fait ici car il y a des besoin de mise à jour du système debian pour rvm
RUN apt-get upgrade -qy > /dev/null

#Install les outils nécessaire pour l'installation de rvm. Enfin Git c'est pour l'avoir au cas ou
#RUN apt-get -y install sudo > dev/null
RUN apt-get install -qy git > /dev/null
RUN apt-get install -qy curl > /dev/null

# Installation du RVM. On install d'abord gpg
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -L https://get.rvm.io | bash -s stable
RUN . /usr/local/rvm/scripts/rvm
RUN /bin/bash -l -c "rvm requirements" > /dev/null
RUN /bin/bash -l -c "rvm install ruby-2" > /dev/null
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc" > /dev/null
RUN echo ". /usr/local/rvm/scripts/rvm" >> /root/.bashrc
CMD /bin/bash
