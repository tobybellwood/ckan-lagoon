#!/bin/bash

# Run any startup scripts provided by images extending this one
if [[ -d "/docker-entrypoint.d" ]]
then
    for f in /docker-entrypoint.d/*; do
        case "$f" in
            *.sh)     echo "$0: Running init file $f"; . "$f" ;;
            *.py)     echo "$0: Running init file $f"; python "$f"; echo ;;
            *)        echo "$0: Ignoring $f (not an sh or py file)" ;;
        esac
        echo
    done
fi

if [ -d /lagoon/entrypoints ]; then
  for i in /lagoon/entrypoints/*; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

# envplate the default lagoon config
if [ -f ${APP_DIR}/ckan.lagoon.ini ]; then
  . ${APP_DIR}/ckan.lagoon.sh
  /bin/ep ${APP_DIR}/ckan.lagoon.ini
  # Merge Lagoon-specific configuration into main CKAN config file
  crudini --merge ${CKAN_INI} < ${APP_DIR}/ckan.lagoon.ini
  cat ${CKAN_INI}
fi

# Run the prerun script to init CKAN and create the default admin user
sudo -u ckan -EH python3 prerun.py

# Ensure correct permissions for CKAN storage
mkdir -p ${CKAN_STORAGE_PATH}/storage/uploads/user && mkdir -p ${CKAN_STORAGE_PATH}/resources
chown -R ckan:ckan ${CKAN_STORAGE_PATH} ${APP_DIR} && chmod -R 777 ${CKAN_STORAGE_PATH}

# Set up datastore permissions
ckan datastore set-permissions | psql "${CKAN_DATASTORE_WRITE_URL}"

# Merge extension configuration options into main CKAN config file.
crudini --merge ${CKAN_INI} < ${APP_DIR}/extension-configs.ini

# Check whether http basic auth password protection is enabled and enable basicauth routing on uwsgi respecfully
if [ $? -eq 0 ]
then
  if [ "$PASSWORD_PROTECT" = true ]
  then
    if [ "$HTPASSWD_USER" ] || [ "$HTPASSWD_PASSWORD" ]
    then
      # Generate htpasswd file for basicauth
      htpasswd -d -b -c /srv/app/.htpasswd $HTPASSWD_USER $HTPASSWD_PASSWORD
      # Start supervisord
      echo "[start_ckan.sh] Starting supervisord."
      supervisord --configuration /etc/supervisord.conf &
    else
      echo "Missing HTPASSWD_USER or HTPASSWD_PASSWORD environment variables. Exiting..."
      exit 1
    fi
  else
    echo "[start_ckan.sh] Starting supervisord."
    # Start supervisord
    supervisord --configuration /etc/supervisord.conf
  fi
else
  echo "[prerun] failed...not starting CKAN."
fi

