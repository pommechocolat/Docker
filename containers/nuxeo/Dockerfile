#http://blog.ineat-conseil.fr/2015/06/docker-pour-les-nuls-avec-nuxeo/

#FROM ubuntu:trusty
#MAINTAINER Grégory Carlin <gregory.carlin@ineat-conseil.fr>
FROM debian
MAINTAINER pommechocolat <dev.pommechocolat@free.fr>

ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
RUN apt-get update > /dev/null
RUN apt-get -y install apt-utils > /dev/null

RUN apt-get install -y wget  > /dev/null
RUN apt-get install -y openjdk-7-jdk  > /dev/null

#Voir la page : http://www.nuxeo.com/fr/telechargez-nuxeo
RUN wget -q -O- http://apt.nuxeo.org/nuxeo.key | apt-key add -

#Install add-apt-repository
RUN apt-get install -y software-properties-common
#RUN add-apt-repository "deb http://apt.nuxeo.org/ trusty fasttracks"
RUN add-apt-repository "deb http://apt.nuxeo.org/ jessie releases"
RUN apt-get update
RUN apt-get install -y nuxeo
RUN apt-get install -y libmysql-java

#configuration pour Mysql. Je vire la config Postgresql
RUN sed -i 's/nuxeo\.templates=postgresql/nuxeo\.templates=mysql/g' /etc/nuxeo/nuxeo.conf
RUN sed -i 's/nuxeo\.db\.port=5433/nuxeo\.db\.port=3306/g' /etc/nuxeo/nuxeo.conf
RUN sed -i 's/nuxeo\.db\.host=localhost/nuxeo\.db\.host=192.168.99.100/g' /etc/nuxeo/nuxeo.conf

RUN ln -s /usr/share/java/mysql.jar /var/lib/nuxeo/server/lib
#RUN echo 'JAVA_OPTS=$JAVA_OPTS -cp /usr/share/java/mysql.jar' >> /etc/nuxeo/nuxeo.conf
#la base est nuxeo/nuxeo/ael1Dai7

#
#RUN apt-add-repository ppa:mc3man/trusty-media
#RUN add-apt-repository ppa:openjdk-r/ppa

#RUN apt-get install -y ffmpeg
#RUN apt-get install -y gstreamer0.10-ffmpeg
#RUN apt-get install -y apache2

ENTRYPOINT nuxeoctl console
