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
RUN yum -y install postgresql93-server postgresql93-contrib; yum clean all
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
    $PGINST/bin/psql --command "CREATE DATABASE bamdb OWNER bam;" && \
    $PGINST/bin/psql --command "CREATE TABLE "hausrat_neugeschaeft"  \ 
    							( pid 				varchar(20),  \
    							  beitrag     		DECIMAL,  \
							      tarif       		varchar(50),  \
							      vertriebskanal    varchar(50),  \
							      qm				INTEGER,  \
							      state				varchar(50),  \
							      datum				TIMESTAMP,  \
							      haustyp			varchar(10) )";


############################################
# lets give the user postgres a HOME-DIR
############################################
USER root
RUN usermod -d $HOME postgres

############################################
# Copy artifacts needed for the Heise_Demo
############################################
ADD . $HOME

############################################
# Copy artifacts to where they belong
############################################
RUN mv $HOME/pgpass $HOME/.pgpass && \
    chown postgres:postgres $HOME/.pgpass && \
    chown -R postgres:postgres $HOME/* && \
    chmod 0600 $HOME/.pgpass 

EXPOSE 5432

USER postgres

CMD ["/usr/pgsql-9.3/bin/postgres", "-D", "/var/lib/pgsql/9.3/data", "-c", "config_file=/var/lib/pgsql/9.3/data/postgresql.conf"]

# Build command -> docker build --rm -t psteiner/postgres .
# run command -> docker run  -p 49380:5432 -d psteiner/postgres
