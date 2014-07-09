# DOCKER-VERSION 0.3.4
FROM    centos

MAINTAINER psteiner <psteiner@redhat.com>

ENV JAVA_HOME /usr/lib/jvm/jre
ENV PGDATA /var/lib/pgsql/9.3/data
ENV PGINST /usr/pgsql-9.3
ENV HOME /root

# Update the system
RUN yum -y update;yum clean all

############################################################################
# Install PostgreSQL 9.3
#
# Code taken from: https://github.com/DataVirtualizationByExample/DVWorkshop
###########################################################################
RUN yum -y install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm
RUN yum -y install postgresql93-server postgresql93-contrib;yum clean all
RUN service postgresql-9.3 initdb

# PostgreSQL setup
USER postgres

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host    all         all         0.0.0.0/0               md5" >> $PGDATA/pg_hba.conf
RUN echo "" >> $PGDATA/pg_hba.conf
RUN echo "listen_addresses='*'" >> $PGDATA/postgresql.conf
RUN echo "" >> $PGDATA/postgresql.conf

#############################################
# Create database for BPM-Suite BAM usage
#############################################
RUN $PGINST/bin/pg_ctl start -w -D $PGDATA && \ 
    $PGINST/bin/psql --command "ALTER USER postgres PASSWORD 'change12_me';" && \
    $PGINST/bin/psql --command "CREATE USER bam PASSWORD 'change12_me';" && \
    $PGINST/bin/psql --command "CREATE DATABASE bamdb OWNER bam;" 

USER root

##############################################
# Need to create a script which is then referenced by the CMD Docker command.
# As the image seems to stop when the command is over, I have added an
# infinit loop. This is ugly, ugly, ugly ... and needs to be solved 
# If you have an idea how, please open an issue!!!
##############################################
RUN echo "service postgresql-9.3 start" > $HOME/start.sh
RUN echo "while true;" >> $HOME/start.sh
RUN echo "do sleep 100" >> $HOME/start.sh
RUN echo "done" >> $HOME/start.sh
RUN chmod +x $HOME/start.sh

EXPOSE 5432

CMD $HOME/start.sh

# Build command -> docker build --rm -t psteiner/postgres .
# run command -> docker run  -p 49380:5432 -d psteiner/postgres
