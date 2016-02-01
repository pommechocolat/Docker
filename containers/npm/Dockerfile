#Docker file par JLM pour avoir un serveur NodeJS

FROM jlm/baseimage
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update > /dev/null
RUN apt-get install -y npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
