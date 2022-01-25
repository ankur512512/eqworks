#!/bin/bash

localexport() {
  docker run -it -e PGPASSWORD=$PGPASSWORD -e PGHOST=$PGHOST -e PGDATABASE=$PGDATABASE -e PGUSER=$PGUSER --rm --entrypoint pg_dump jbergknoff/postgresql-client -O -C -x > $hostdir/mysqldump.sql
}

if [ -d "$hostdir" ]; then
echo "Directory already exists" ;
  if [ -z "$(ls -A $hostdir)" ]; then
     echo "Empty. Populating this directory using postgresql client."
     localexport
  fi

## Running postgresql database server with host volume.

else
`mkdir -p $hostdir`;
echo "$hostdir directory is created"
localexport
fi

echo -e "Running docker-compose command now... make sure you have docker-compose command installed and available in your PATH\n"
docker-compose up --build -d
