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

docker-compose up --build -d
