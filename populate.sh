#!/bin/bash

# Function to take mysql dump from remote server to local volume

localexport() {
  docker run -it -e PGPASSWORD=$PGPASSWORD -e PGHOST=$PGHOST -e PGDATABASE=$PGDATABASE -e PGUSER=$PGUSER --rm --entrypoint pg_dump jbergknoff/postgresql-client -O -C -x > $hostdir/mysqldump.sql
}


#Checking if directory and mysqldump already exists
if [ -d "$hostdir" ]; then
echo "Directory already exists" ;
  if [ -z "$(ls -A $hostdir)" ]; then
     echo "Empty. Populating this directory using postgresql client."
     localexport
  fi

## Creating directory and populating with mysqlpdump
else
`mkdir -p $hostdir`;
echo -e "$hostdir directory is created.\n Now populating $hostdir with mysqldump"
localexport
fi

echo -e "Running docker-compose command now... make sure you have docker-compose command installed and available in your PATH\n"
docker-compose up --build -d
