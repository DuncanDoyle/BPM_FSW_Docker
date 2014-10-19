# DOCKER-VERSION 0.3.4
FROM psteiner/datavirt

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Update the system
RUN yum -y update && yum clean all

USER jbosseap

EXPOSE 22 3306 5432 8080 9990 9999 27017 31000

CMD $HOME/dv/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0

# Build command -> docker build --rm -t psteiner/heise_datavirt .
# Run with command line -> docker run -P -i -t psteiner/heise_datavirt /bin/bash
