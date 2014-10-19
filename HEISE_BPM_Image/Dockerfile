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
RUN mkdir $HOME/.niogit && \
 cp -R $HOME/tmp/niogit/* $HOME/.niogit && \
 cp $HOME/tmp/BiPRO-Komposit-JAXB2-1.0.0.jar $HOME/eap/jboss-eap-6.1/standalone/deployments/business-central.war/WEB-INF/lib/ && \
 cp $HOME/tmp/configs/standalone.xml $HOME/eap/jboss-eap-6.1/standalone/configuration  && \
 cp $HOME/tmp/postgresql-8.4-703.jdbc4.jar $HOME/eap/jboss-eap-6.1/standalone/deployments && \
 cp $HOME/tmp/configs/heise*.xml $HOME/eap/jboss-eap-6.1/standalone/deployments/dashbuilder.war/WEB-INF/etc/appdata/initialData && \
 cp $HOME/tmp/dashboard-importer/target/heisedemo-dashboard.jar $HOME/eap/jboss-eap-6.1/standalone/deployments/dashbuilder.war/WEB-INF/lib && \
 chown -R jbosseap:jbosseap $HOME

############################################
# Define command to start image
############################################
USER root

# Changing to directory $HOME so the .index directory is created in the correct place
# TODO maybe configure uberfire correctly to configure the org.uberfire.metadata.index.dir property
CMD su jbosseap -c "cd /home/jbosseap; ./eap/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0"
EXPOSE 22 8080 9990

# Build command -> docker build --rm -t psteiner/heise_bpm .
# run command -> docker run -p 49160:8080 -p 49170:9990 -d psteiner/heise_bpm
