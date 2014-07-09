# DOCKER-VERSION 0.3.4
FROM    psteiner/bpm

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Update the system
RUN yum -y update;yum clean all

############################################
# Copy artifacts needed for the Heise_Demo
############################################
ADD . $HOME/tmp/

############################################
# Copy artifacts to where they belong
############################################
RUN mkdir /.niogit
RUN cp -R $HOME/tmp/niogit/* /.niogit
RUN cp $HOME/tmp/BiPRO-Komposit-JAXB2-1.0.0.jar $HOME/eap/jboss-eap-6.1/standalone/deployments/business-central.war/WEB-INF/lib/

############################################
# Define command to start image
############################################
USER jbosseap
CMD $HOME/eap/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/heise_bpm .
# run command -> docker run -p 49160:8080 -p 49170:9990 -d psteiner/heise_bpm
