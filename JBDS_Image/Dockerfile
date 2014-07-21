# DOCKER-VERSION 0.3.4
FROM   psteiner/eap

MAINTAINER wrichter <wrichter@redhat.com>

USER root

RUN yum -y install libcanberra-gtk2 PackageKit-gtk-module

USER jbosseap
   
ADD . $HOME/tmp/

RUN java -jar $HOME/tmp/jbdevstudio-product-universal-7.1.1.GA-v20140314-2145-B688.jar $HOME/tmp/InstallConfigRecord.xml 

CMD $HOME/jbdevstudio/jbdevstudio-unity

# Build command -> docker build --rm -t wrichter/jbds .
# run command -> docker run -i -t -e DISPLAY=unix$DISPLAY -e TERM=$TERM -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/snd:/dev/snd --lxc-conf='lxc.cgroup.devices.allow = c 116:* rwm' wrichter/jbds
