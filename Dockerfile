# NTIPA-Jbilling-Docker
FROM tornabene/docker-ntipa-base

MAINTAINER Giambanco Giuseppe <giambancogiuseppe@yahoo.it>

RUN apt-get -y install vim git zip unzip bzip2 fontconfig
RUN apt-get -y install sudo wget tar curl


# mi posiziono sul contesto della cartella opt
WORKDIR /opt
# Download jbilling
RUN wget http://cznic.dl.sourceforge.net/project/jbilling/jbilling%20Latest%20Stable/jbilling-3.1.0/jbilling-community-3.1.0.zip -O jbilling-community-3.1.0.zip
# qui scompatterò il file da scaricare (link da verificare )
RUN unzip jbilling-community-3.1.0.zip
#Privilegi per installare jbilling
WORKDIR /opt/jbilling-community-3.1.0/bin
RUN chmod +x *.sh


#Allego supervisor

ADD jbilling.conf  /etc/supervisor/conf.d/jbilling.conf


EXPOSE 8080

CMD /usr/bin/supervisord