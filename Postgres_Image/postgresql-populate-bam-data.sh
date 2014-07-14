#!/bin/bash

service postgresql-9.3 start

psql -d bamdb -U bam -f /home/jboss/images/postgresql-test.sql

service postgresql-9.3 stop

runuser -l postgres -c '/usr/pgsql-9.3/bin/postgres -D /var/lib/pgsql/9.3/data -c config_file=/var/lib/pgsql/9.3/data/postgresql.conf'
