# DOCKER-VERSION 0.3.4
FROM    psteiner/eap

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Update the system
RUN yum -y update;yum clean all

############################################
# Copy JBoss BPM-Suite
############################################
ADD . $HOME/tmp/

RUN /usr/bin/unzip -qo $HOME/tmp/jboss-bpms-6.0.1.GA-redhat-4-deployable-eap6.x.zip -d $HOME/eap

############################################
# Copy files to have some initial users
############################################
RUN cp $HOME/tmp/application-users.properties $HOME/eap/jboss-eap-6.1/standalone/configuration
RUN cp $HOME/tmp/application-roles.properties $HOME/eap/jboss-eap-6.1/standalone/configuration

############################################
# Define command to start image
############################################
CMD $HOME/eap/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/bpm .
# run command -> docker run -p 49160:8080 -p 49170:9990 -d psteiner/bpm
