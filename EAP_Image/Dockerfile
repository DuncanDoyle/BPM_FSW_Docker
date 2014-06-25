# DOCKER-VERSION 0.3.4
FROM    centos:6.4

MAINTAINER psteiner <psteiner@redhat.com>

# Update the system
# RUN yum -y update;yum clean all

##########################################################
# Install some missing stuff
##########################################################
RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel unzip;yum clean all
RUN yum -y install unzip
RUN yum -y install java-1.7.0-openjdk
RUN yum clean all;

ENV JAVA_HOME /usr/lib/jvm/jre


############################################
# Create user to run JBoss EAP
############################################
RUN useradd -m -d /home/jbosseap -p jbosseap jbosseap 

############################################
# Install JBoss EAP 6.1.1
############################################
USER jbosseap

ENV HOME /home/jbosseap
RUN mkdir $HOME/eap
RUN mkdir $HOME/tmp
   
ADD . $HOME/tmp/

RUN /usr/bin/unzip -q $HOME/tmp/jboss-eap-6.1.*.zip -d $HOME/eap

RUN cp $HOME/tmp/mgmt-users.properties $HOME/eap/jboss-eap-6.1/standalone/configuration

CMD $HOME/eap/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/eap .
# run command -> docker run -p 49160:8080 -p 49170:9990 -d psteiner/eap
