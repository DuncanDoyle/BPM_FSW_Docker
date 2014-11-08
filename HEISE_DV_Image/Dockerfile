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

CMD /home/jboss/run.sh

# Build command -> docker build --rm -t psteiner/dv_heise .
# run command -> docker run -i -t -e DISPLAY=unix$DISPLAY -e TERM=$TERM -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/snd:/dev/snd --lxc-conf='lxc.cgroup.devices.allow = c 116:* rwm' psteiner/heise_dv
