#######################################################################
#                                                                     #
# Creates a base Fedora image with JBoss Data Virtualization 6.0.0.GA #
#                                                                     #
#######################################################################

# Use the centos base image
FROM centos:centos6

MAINTAINER kpeeples <kpeeples@redhat.com>
MAINTAINER psteiner <psteiner@redhat.com>


# Update the system
RUN yum -y update;yum clean all

# enabling sudo group for jboss
RUN echo '%jboss ALL=(ALL) ALL' >> /etc/sudoers

# Create jboss user
RUN useradd -m -d /home/jboss -p jboss jboss

# Make sure the password for jboss is really set
RUN echo "jboss:jboss" | /usr/sbin/chpasswd


##########################################################
# Install Java JDK, SSH and other useful cmdline utilities
##########################################################
RUN yum -y install java-1.7.0-openjdk which telnet unzip openssh-server sudo openssh-clients;yum clean all
ENV JAVA_HOME /usr/lib/jvm/jre

# Install MySQL JDBC Client
RUN yum -y install mysql-connector-java;yum clean all

############################################
# Install JBoss Data Virtualization 6.0.0.GA
############################################
USER jboss
ENV INSTALLDIR /home/jboss/dv
ENV HOME /home/jboss
RUN mkdir $INSTALLDIR && \
   mkdir $INSTALLDIR/software && \
   mkdir $INSTALLDIR/support && \
   mkdir $INSTALLDIR/jdbc

ADD software/jboss-dv-installer-6.0.0.GA-redhat-4.jar $INSTALLDIR/software/jboss-dv-installer-6.0.0.GA-redhat-4.jar 
ADD support/teiid-security-users.properties $INSTALLDIR/support/teiid-security-users.properties
ADD support/teiid-security-roles.properties $INSTALLDIR/support/teiid-security-roles.properties
ADD support/InstallationScript.xml $INSTALLDIR/support/InstallationScript.xml
ADD support/mgmt-users.properties $INSTALLDIR/support/mgmt-users.properties


RUN java -jar $INSTALLDIR/software/jboss-dv-installer-6.0.0.GA-redhat-4.jar $INSTALLDIR/support/InstallationScript.xml
RUN mv $INSTALLDIR/support/teiid* $INSTALLDIR/jboss-eap-6.1/standalone/configuration
RUN mv $INSTALLDIR/support/mgmt-users.properties $INSTALLDIR/jboss-eap-6.1/standalone/configuration
RUN curl -o $INSTALLDIR/jdbc/postgresql-9.3-1101.jdbc41.jar http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar
RUN rm -rf $INSTALLDIR/jboss-eap-6.1/standalone/configuration/standalone_xml_history/current

# Command line shortcuts
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre" >> $HOME/.bash_profile
RUN echo "alias ll='ls -l --color=auto'" >> $HOME/.bash_profile
RUN echo "alias grep='grep --color=auto'" >> $HOME/.bash_profile
RUN echo "alias c='clear'" >> $HOME/.bash_profile
RUN echo "alias sdv='$HOME/dv/jboss-eap-6.1/bin/standalone.sh -c standalone.xml'" >> $HOME/.bash_profile
RUN echo "alias xdv='$HOME/dv/jboss-eap-6.1/bin/jboss-cli.sh --commands=connect,:shutdown'" >> $HOME/.bash_profile

# start.sh
USER root
RUN echo "#!/bin/sh"
RUN echo "echo JBoss Data Virtualization Start script" >> $HOME/run.sh
RUN echo "service sshd start " >> $HOME/run.sh
RUN echo "service mysqld start " >> $HOME/run.sh
RUN echo "runuser -l jboss -c '$HOME/dv/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0'" >> $HOME/run.sh
RUN chmod +x $HOME/run.sh

# Clean up
RUN rm -rf $INSTALLDIR/support
RUN rm -rf $INSTALLDIR/software

EXPOSE 22 3306 5432 8080 9990 27017 9999

CMD /home/jboss/run.sh

# docker run -P -i -t psteiner/datavirt /bin/bash
