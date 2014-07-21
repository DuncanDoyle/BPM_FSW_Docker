# DOCKER-VERSION 0.3.4
FROM    centos:centos6

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Install some missing stuff
RUN yum -y update && \
 yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel unzip openssh-server openssh-clients && \
 yum clean all

# Make sure JAVA_HOME is set
ENV JAVA_HOME /usr/lib/jvm/jre

# Create user to run JBoss EAP
RUN useradd -m -d /home/jbosseap -p jbosseap jbosseap 

# Set root password
RUN echo "root:redhat" | /usr/sbin/chpasswd

# Install JBoss EAP 6.1.1
ENV HOME /home/jbosseap

ADD . $HOME/tmp/

RUN mkdir $HOME/fsw; mkdir $HOME/tmp; chown -R jbosseap:jbosseap /home/jbosseap 

# Switch back to jbosseap for the rest
USER jbosseap

RUN java -jar $HOME/tmp/jboss-fsw-installer-6.0.0.GA-redhat-4.jar $HOME/tmp/config.xml -variablefile $HOME/tmp/config.xml.variables && \
 cp $HOME/tmp/mgmt-users.properties $HOME/fsw/jboss-eap-6.1/standalone/configuration

#Clean up
RUN rm $HOME/tmp/*

CMD $HOME/fsw/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/fsw .
# run command -> docker run -p 49180:8080 -p 49190:9990 -d psteiner/fsw
