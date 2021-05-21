#!/bin/bash

# Use the Lagoon variables to set the default CKAN ones
export CKAN_SQLALCHEMY_URL=postgresql://${DB_USERNAME:-lagoon}:${DB_PASSWORD:-lagoon}@${DB_HOST:-db}:${DB_PORT:-5432}/${DB_DATABASE:-lagoon}
export CKAN_DATASTORE_WRITE_URL=postgresql://${DATASTORE_USERNAME:-lagoon}:${DATASTORE_PASSWORD:-lagoon}@${DATASTORE_HOST:-datastore}:${DATASTORE_PORT:-5432}/${DATASTORE_DATABASE:-lagoon}
export CKAN_DATASTORE_READ_URL=postgresql://${DATASTORE_READONLY_USER:-datastore_ro}:${DATASTORE_READONLY_PASSWORD:-datastore_ro}@${DATASTORE_HOST:-datastore}:${DATASTORE_PORT:-5432}/${DATASTORE_DATABASE:-lagoon}
export CKAN_REDIS_URL=${CKAN_REDIS_URL:-redis://redis:6379/0}
export CKAN_SOLR_URL=${CKAN_SOLR_URL:-http://solr:8983/solr/ckan}
export CKAN_SITE_ID=${LAGOON_PROJECT:-ckanlagoon}
export CKAN_SITE_URL=${LAGOON_ROUTE:-http://localhost:5000/}
export CKAN_STORAGE_PATH=${CKAN_STORAGE_PATH:-/var/lib/ckan}
export CKAN_SMTP_SERVER=${CKAN_SMTP_SERVER:-smtp.corporateict.domain:25}
export CKAN_SMTP_STARTTLS=${CKAN_SMTP_STARTTLS}
export CKAN_SMTP_USER=${CKAN_SMTP_USER:-user}
export CKAN_SMTP_PASSWORD=${CKAN_SMTP_PASSWORD:-pass}
export CKAN_SMTP_MAIL_FROM=${CKAN_SMTP_MAIL_FROM:-ckan@localhost}
export CKAN_MAX_UPLOAD_SIZE_MB=${CKAN_MAX_UPLOAD_SIZE_MB:-100}
export CKAN__PLUGINS="datastore xloader harvest ckan_harvester scheming_organizations scheming_datasets scheming_groups"