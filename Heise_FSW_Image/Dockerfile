# DOCKER-VERSION 0.3.4
FROM    psteiner/fsw

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Update the system
RUN yum -y update;yum clean all

############################################
# Add our webservice to the FSW image
############################################
ADD . $HOME/tmp/

RUN cp $HOME/tmp/TarifierungsService.jar $HOME/fsw/jboss-eap-6.1/standalone/deployments

RUN chown -R jbosseap:jbosseap $HOME/fsw/jboss-eap-6.1/standalone/deployments/T* 

############################################
# Switch back to jbosseap for the rest
############################################
USER jbosseap

CMD $HOME/fsw/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/fsw_heise .
# run command -> docker run -p 49260:8080 -p 49270:9990 -d psteiner/fsw_heise
