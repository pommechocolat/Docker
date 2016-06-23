#Mise en œuvre pour un démarrage automatique avec docker-compose
FROM jlmunivlorraine/nuxeo_ul_conf
MAINTAINER jlmunivlorraine <jean-luc.metzger@univ-lorraine.fr>

RUN sed -i 's/nuxeo\.db\.port=6606/nuxeo\.db\.port=3306/g' /etc/nuxeo/nuxeo.conf
RUN sed -i 's/nuxeo\.db\.host=192.168.99.100/nuxeo\.db\.host=194.199.223.112/g' /etc/nuxeo/nuxeo.conf
RUN rm -rf /var/log/nuxeo/*
RUN rm -fr /tmp/*
RUN apt-get clean

ADD ./start.sh /opt/startup.sh
RUN chmod 755 /opt/startup.sh
CMD ["/opt/startup.sh"]
