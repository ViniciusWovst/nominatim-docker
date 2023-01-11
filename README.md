# Nominatim Docker (Nominatim version 4.2)
Docker compose for Nominatim tested in version 4.2

## Introduction 
This docker image build and run [Nominatim](https://nominatim.org).

It´s necessary a [postgres database](https://www.postgresql.org) and [postgis](https://postgis.net) previous configured

## Build 
Build image using ```docker-compose build```

## Configuration
The following environment variables are available for configuration:
- `PBF_URL`: Which [OSM extract](#openstreetmap-data-extracts) to download and import. Check [https://download.geofabrik.de](https://download.geofabrik.de)
- `THREADS`: How many threads should be used to import (default: `16`)
- `NOMINATIM_PASSWORD`: The password to connect to the database with (default: `123456` - Please change this password)
- `PGHOST`: Postgres host
- `PGPASSWORD`: Postgres password
- `PGUSER`: Postgres user
- `PGDATABASE`: postgres database name (default: ```nominatim```)
- `NOMINATIM_DATABASE_DSN`: postgres string connection (e.g: ```pgsql:dbname=nominatim;hostaddr=173.16.238.2;user=your_user_database;password=your_password_database```)


## Run 
Run image using ```docker-compose up```

## Finally 
By default will run in port 8087. 

If everything runs ok, You can check on http://localhost:8087/search.php?q=avenue%20pasteur

## PostgreSQL Tuning
See https://nominatim.org/release-docs/4.2.0/admin/Installation/#tuning-the-postgresql-database for more details about postgreSQL tuning
