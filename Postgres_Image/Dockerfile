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

EXPOSE 5432

USER postgres

CMD ["/usr/pgsql-9.3/bin/postgres", "-D", "/var/lib/pgsql/9.3/data", "-c", "config_file=/var/lib/pgsql/9.3/data/postgresql.conf"]

# Build command -> docker build --rm -t psteiner/postgres .
# run command -> docker run  -p 49380:5432 -d psteiner/postgres
