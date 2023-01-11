#!/bin/bash -ex
 
 IMPORT_FINISHED=/app/completed

 
 if [ ! -f ${IMPORT_FINISHED} ]; then
  /app/scripts/init.sh
  touch ${IMPORT_FINISHED}
else
  chown -R nominatim:nominatim /app
fi

 sudo -E -u nominatim nominatim refresh --website --functions

 service apache2 start

# fork a process and wait for it
tail -Fv /var/log/apache2/access.log /var/log/apache2/error.log  &
tailpid=${!}


echo "Warm database caches for search and reverse queries"
sudo -E -u nominatim nominatim admin --warm > /dev/null

echo "Warming finished"

echo "--> Nominatim is ready to accept requests"

wait

