ARG IMAGE_REPO
FROM ${IMAGE_REPO:-uselagoon}/postgres-11

# Allow connections; we don't map out any ports so only linked docker containers can connect
RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf

# Customize default user/pass/db
ENV POSTGRES_DB lagoon
ENV POSTGRES_USER lagoon
ARG POSTGRES_PASSWORD
ARG DATASTORE_READONLY_PASSWORD

# Include extra setup scripts (eg datastore)
ADD postgresql/docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
COPY .env ${APP_DIR}