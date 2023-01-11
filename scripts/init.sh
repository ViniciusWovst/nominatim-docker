#!/bin/bash -ex

sudo -E -u postgres psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='www-data'" | grep -q 1 || sudo -E -u postgres createuser -SDR www-data

sudo -E -u postgres psql postgres -c "DROP DATABASE IF EXISTS nominatim"

if [ -f osmdata/data.osm.pbf ]; then
  echo "data already exists"
else
  echo "osm data not found !"
  echo Downloading OSM extract from "$PBF_URL"
  wget -O osmdata/data.osm.pbf "$PBF_URL"  
fi

nominatim import --osm-file osmdata/data.osm.pbf --threads $THREADS


touch /app/completed