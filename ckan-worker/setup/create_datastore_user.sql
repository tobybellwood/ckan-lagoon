\set datastore_ro_password '\'' `echo $DATASTORE_READONLY_PASSWORD` '\''
\set datastore_ro_role `echo $DATASTORE_READONLY_USER`

CREATE ROLE :datastore_ro_role NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD :datastore_ro_password;