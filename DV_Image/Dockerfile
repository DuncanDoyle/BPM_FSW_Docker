# DOCKER-VERSION 0.3.4
FROM    mattdm/fedora:f20

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Set root password
RUN echo "root:change12_me" | /usr/sbin/chpasswd

# Update the system
RUN yum -y update && yum clean all
RUN yum -y install perl java-1.7.0-openjdk openssh-server openssh-clients unzip sudo mysql-connector-java;yum clean all

ENV JAVA_HOME /usr/lib/jvm/jre
ENV HOME /home/jbosseap

# enable networking
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# Create user to run JBoss DV
RUN useradd -m -d /home/jbosseap -p jbosseap jbosseap


USER jbosseap

RUN mkdir $HOME/tmp && \
    mkdir $HOME/dv && \
    mkdir $HOME/dv/jdbc

ADD ./software $HOME/tmp
ADD ./configs $HOME/tmp 

# Install Red Hat JBoss Data Virtualisation
RUN java -jar $HOME/tmp/jboss-dv-installer-6.0.0.GA-redhat-4.jar $HOME/tmp/dv_install_script.xml

# Copy configuration for Red Hat JBoss Data Virtualisation
RUN mv $HOME/tmp/teiid* $HOME/dv/jboss-eap-6.1/standalone/configuration

# Retrieve Postgres JDBC driver
RUN curl -o $HOME/dv/jdbc/postgresql-9.3-1101.jdbc41.jar http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar


EXPOSE 22 3306 5432 8080 9990 9999 27017 31000

CMD $HOME/dv/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0

# Build command -> docker build --rm -t psteiner/datavirt .
# Run with command line -> docker run -P -i -t psteiner/datavirt /bin/bash
