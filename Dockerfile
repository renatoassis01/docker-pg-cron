## postgres with extension pg_cron https://github.com/citusdata/pg_cron

FROM postgres:12

ARG POSTGRES_DB


RUN apt-get update \
    && apt-get install -y postgresql-12-cron

RUN mkdir -p /docker-entrypoint-initdb.d

RUN echo "shared_preload_libraries = 'pg_cron'" >> /var/lib/postgresql/data/postgresql.conf \
    && echo "shared_preload_libraries = 'pg_cron'" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "cron.database_name = '${POSTGRES_DB}'" >> /var/lib/postgresql/data/postgresql.conf \
    && echo "cron.database_name = '${POSTGRES_DB}'" >>  /usr/share/postgresql/postgresql.conf.sample \
    && echo "CREATE EXTENSION pg_cron;" >> /docker-entrypoint-initdb.d/003-setup-cron.sql \
