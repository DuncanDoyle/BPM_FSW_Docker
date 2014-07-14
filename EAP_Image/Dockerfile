# DOCKER-VERSION 0.3.4
FROM    centos:centos6

MAINTAINER psteiner <psteiner@redhat.com>

# Update the system and Install necessary RPMs
RUN yum -y update && \ 
 yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel unzip openssh-server openssh-clients  && \
 yum clean all

# Make sure JAVA_HOME is set
ENV JAVA_HOME /usr/lib/jvm/jre

# Set root password
RUN echo "root:redhat" | /usr/sbin/chpasswd

# Create user to run JBoss EAP
RUN useradd -m -d /home/jbosseap -p jbosseap jbosseap 

# Install JBoss EAP 6.1.1
USER jbosseap

ENV HOME /home/jbosseap
RUN mkdir $HOME/eap && \
 mkdir $HOME/tmp
   
ADD . $HOME/tmp/

RUN /usr/bin/unzip -q $HOME/tmp/jboss-eap-6.1.*.zip -d $HOME/eap && \
 cp $HOME/tmp/mgmt-users.properties $HOME/eap/jboss-eap-6.1/standalone/configuration

CMD $HOME/eap/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/eap .
# run command -> docker run -p 49160:8080 -p 49170:9990 -d psteiner/eap
