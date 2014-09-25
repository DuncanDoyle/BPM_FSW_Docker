# DOCKER-VERSION 0.3.4
FROM    centos:centos6

MAINTAINER psteiner <psteiner@redhat.com>

ENV JAVA_HOME /usr/lib/jvm/jre
ENV PGDATA /var/lib/pgsql/9.3/data
ENV PGINST /usr/pgsql-9.3
ENV HOME /home/postgres

# Update the system
RUN yum -y update;yum clean all

############################################################################
# Install PostgreSQL 9.3
#
# Code taken from: https://github.com/DataVirtualizationByExample/DVWorkshop
###########################################################################
RUN yum -y install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm
RUN yum -y install postgresql93-server postgresql93-contrib sudo; yum clean all
RUN service postgresql-9.3 initdb

############################################
# Copy artifacts needed for the Heise_Demo
############################################
ADD . $HOME

############################################
# lets give the user postgres a HOME-DIR
############################################
USER root
RUN usermod -d $HOME postgres

#############################################
# Create database for BPM-Suite BAM usage
#############################################
USER postgres

RUN $PGINST/bin/pg_ctl start -w -D $PGDATA && \ 
   $PGINST/bin/psql --command "ALTER USER postgres PASSWORD 'change12_me';" && \
   $PGINST/bin/psql --command "CREATE USER bam PASSWORD 'change12_me';" && \
   $PGINST/bin/psql --command "CREATE DATABASE bamdb OWNER bam;" 


############################################
# Copy artifacts to where they belong
############################################
USER root

RUN mv $HOME/pgpass /root/.pgpass && \
   chmod 0600 /root/.pgpass && \
   chmod +x $HOME/postgresql-populate-bam-data.sh  && \
   mv $HOME/pg_hba.conf $PGDATA  && \
   chmod +r $PGDATA/pg_hba.conf

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "listen_addresses='*'" >> $PGDATA/postgresql.conf
RUN echo "" >> $PGDATA/postgresql.conf

EXPOSE 5432

USER root

CMD $HOME/postgresql-populate-bam-data.sh

# Build command -> docker build --rm -t psteiner/postgres .
# run command -> docker run  -p 49380:5432 -d psteiner/postgres
