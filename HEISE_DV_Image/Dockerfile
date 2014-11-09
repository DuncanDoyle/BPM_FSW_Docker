#######################################################################
#                                                                     #
# Creates a base Fedora image with JBoss Data Virtualization 6.0.0.GA #
#                                                                     #
#######################################################################

# Use the centos base image
FROM psteiner/datavirt

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Update the system
RUN yum -y update;yum clean all
# RUN yum -y install libcanberra-gtk2 PackageKit-gtk-module java-1.7.0-openjdk-devel

# Create the datasource in EAP
RUN mkdir $INSTALLDIR/support
ADD config/standalone.xml $INSTALLDIR/support/standalone.xml
RUN mv $INSTALLDIR/support/standalone.xml $INSTALLDIR/jboss-eap-6.1/standalone/configuration/standalone.xml
RUN rm -rf $INSTALLDIR/support

EXPOSE 22 3306 5432 8080 9990 27017 9999

CMD /home/jboss/run.sh

# Build command -> docker build --rm -t psteiner/dv_heise .
# docker run -P -i -t psteiner/heise_datavirt /bin/bash