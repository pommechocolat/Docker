#http://blog.ineat-conseil.fr/2015/06/docker-pour-les-nuls-avec-nuxeo/

FROM debian:jessie
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>

RUN apt-get update > /dev/null
RUN apt-get -y install apt-utils > /dev/null
#permet à update de faire confiance au depôt nuxeo
RUN apt-get install -y wget > /dev/null
RUN wget -q -O- http://apt.nuxeo.org/nuxeo.key | apt-key add -

RUN echo "deb http://apt.nuxeo.org/ jessie releases" > /etc/apt/sources.list.d/nuxeo.list
RUN apt-get update > /dev/null


#Voir la page : http://www.nuxeo.com/fr/telechargez-nuxeo
RUN apt-get install -y nuxeo=6.0-01 > /dev/null
RUN apt-get install -y libmysql-java
RUN ln -s /usr/share/java/mysql.jar /var/lib/nuxeo/server/lib

#configuration pour Mysql. Je vire la config Postgresql
RUN sed -i 's/nuxeo\.templates=postgresql/nuxeo\.templates=mysql/g' /etc/nuxeo/nuxeo.conf
RUN sed -i 's/nuxeo\.db\.port=5433/nuxeo\.db\.port=3306/g' /etc/nuxeo/nuxeo.conf
RUN sed -i 's/nuxeo\.db\.host=localhost/nuxeo\.db\.host=194.199.223.112/g' /etc/nuxeo/nuxeo.conf

#RUN echo 'JAVA_OPTS=$JAVA_OPTS -cp /usr/share/java/mysql.jar' >> /etc/nuxeo/nuxeo.conf
#la base est nuxeo/nuxeo/ael1Dai7

#RUN apt-add-repository ppa:mc3man/trusty-media
#RUN add-apt-repository ppa:openjdk-r/ppa

#RUN apt-get install -y ffmpeg
#RUN apt-get install -y gstreamer0.10-ffmpeg

RUN apt-get clean
RUN rm -rf /tmp/* /var/tmp/*
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT nuxeoctl start -d
#CMD ["/bin/bash"]
