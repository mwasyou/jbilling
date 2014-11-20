# NTIPA-Jbilling-Docker
FROM ubuntu:trusty

MAINTAINER Giambanco Giuseppe <giambancogiuseppe@yahoo.it>

RUN apt-get update
RUN apt-get -y upgrade
#RUN apt-get -y -q  install  python-software-properties software-properties-common
RUN apt-get -y install openssh-server && mkdir /var/run/sshd
RUN apt-get -y install vim git zip unzip bzip2
RUN apt-get -y install sudo wget tar curl
RUN apt-get -y install supervisor
RUN apt-get install -yqq inetutils-ping net-tools




#Installa open-jdk
RUN apt-get -y install openjdk-7-jre


# install oracle java from PPA
#RUN add-apt-repository ppa:webupd8team/java -y
#RUN apt-get update
#RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/#debconf-set-selections
#RUN apt-get -y install oracle-java7-installer && apt-get clean

# Set oracle java as the default java
#RUN update-java-alternatives -s java-7-oracle
#RUN echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> ~/.bashrc

#Allego supervisor
WORKDIR /etc/supervisor/conf.d
RUN mkdir -p   /var/run/sshd /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# mi posiziono sul contesto della cartella opt
WORKDIR /opt


# Download jbilling
RUN wget http://cznic.dl.sourceforge.net/project/jbilling/jbilling%20Latest%20Stable/jbilling-3.1.0/jbilling-community-3.1.0.zip -O jbilling-community-3.1.0.zip

# qui scompatter� il file da scaricare (link da verificare )
RUN unzip jbilling-community-3.1.0.zip


# mi sposto su /opt/jbilling-community-3.1.0/bin
WORKDIR /opt/jbilling-community-3.1.0

#Privilegi per installare jbilling
RUN chmod +x bin/*.sh
WORKDIR /opt/jbilling-community-3.1.0/lib
RUN wget http://central.maven.org/maven2/org/postgresql/postgresql/9.3-1100-jdbc41/postgresql-9.3-1100-jdbc41.jar
RUN wget http://central.maven.org/maven2/org/hsqldb/hsqldb/2.2.8/hsqldb-2.2.8.jar

#sudo mkdir -p /home/jbilling/jbilling/enterprise/image/bin/hsql/
#sudo chmod 777  /home/jbilling/
#sudo  chmod -R 777  /home/jbilling/


ADD jbilling-DataSource.groovy /opt/jbilling-community-3.1.0/jbilling/jbilling-DataSource.groovy

# configure the "ntipa" and "root" users
RUN echo 'root:ntipa' |chpasswd
RUN groupadd ntipa && useradd ntipa -s /bin/bash -m -g ntipa -G ntipa && adduser ntipa sudo
RUN echo 'ntipa:ntipa' |chpasswd	
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


# expose the SSHD port, and run SSHD
EXPOSE 8080
EXPOSE 22


CMD ["/usr/bin/supervisord"]