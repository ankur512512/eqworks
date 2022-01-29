# Eqworks
Devops + Terraform + Github actions + Python + docker-compose

### Prerequisites:

* docker and docker-compose
* minikube local cluster
* terraform

### Commons Steps:

To start with, first clone this repo in you linux server:

``` 
$ git clone https://github.com/ankur512512/eqworks.git
$ cd eqworks
```

## 1. Containerization

Here, we have containerized the python application using `Dockerfile` and then used a postgresql client (using a docker image) to fetch and store data from remote server (*details of which were given in the question repo*) to a local directory. That sql dump is then used to spin up a new postgresql docker container with our own credentials which will be used by our application.

To build the docker image, for the application api, from Dockerfile; use below command:

```
$ docker build -t ankur512512/eqworks-api:1.0 .
```

Now, we can use the whole application stack including DB using the `docker-compose.yaml` file. To do that first export the below environment variables in your shell:

```
## User defined values for our own database. Give any of your choice.

$ export hostdir=/var/tmp  #Directory where sqldump file will be created. Make sure your user has access to create/read this directory
$ export DB_USER=ankur
$ export DB_PASSWORD=ankur123

## Remote database values given by EQWORKS in the assignment

$ export PGHOST=<enter-hostname-here>
$ export PGPORT=<enter-portnumber-here>
$ export PGDATABASE=<enter-database-name-here>
$ export PGUSER=<enter-username-here>
$ export PGPASSWORD=<enter-password-here>
```

After that just execute the `populate.sh` script as below and it will automatically check if sqldump is already present or not and will export the backup accordingly and then run our own postgres database container to be used by the application. This single script will take care of populating the sql data and then running the whole application stack (*both api and db containers*) using `docker-compose`.

```
$ bash ./populate.sh
```

It will sleep for 15 seconds so that both the api and db containers are running fine and will automatically curl the required url as well for you. Still to check if connectivity is working fine with both api and db use below command:

```
$ curl localhost:5000/poi
```

You should see results like below:

```
[{"lat":43.6708,"lon":-79.3899,"name":"EQ Works","poi_id":1},{"lat":43.6426,"lon":-79.3871,"name":"CN Tower","poi_id":2},{"lat":43.0896,"lon":-79.0849,"name":"Niagara Falls","poi_id":3},{"lat":49.2965,"lon":-123.0884,"name":"Vancouver Harbour","poi_id":4}]
```

This verifies that our application `api` is working fine and is also able to connect to the `db` service. Once you are done with the testing do a cleanup of everything using below command:

```
$ docker-compose rm -sf
```

## 2. Continuous integration and deployment

Github-actions is configured for this repo to automatically build and publish the docker `api` image to docker hub, only when a new release is published. To see the results for the same, go to this link:

https://github.com/ankur512512/eqworks/runs/4772644827?check_suite_focus=true

Notice that the image `ankur512512/eqworks-api:1.0` is being pushed to docker hub. You can check all the tags of the image at `docker-hub` here:

https://hub.docker.com/r/ankur512512/eqworks-api/tags

This published image is then used in the next steps in `kubernetes`.

## 3. Infrastructure codification

In this step we will use the `terraform` manifests to automatically create pods and services for both api and db. We will be creating `ClusterIP` service for db as we want it to be used internally by the api only and `NodePort` service for the api as we want to be able to access it from outside the k8s cluster (on cloud infrastructure `LoadBalancer` service could be used as well). For the db part, I have used a db image that I built having all the data taken from the backup database server already, as using volume mounts was not that straight forward with `minikube`.

Please export the below environment variables first:

```
## Give any value of your choice to connect to postgresql database

$ export TF_VAR_db_user=ankur   #Username to access your database
$ export TF_VAR_db_pass=ankur123  #Password to access your database
```

After this, run the below shell script to automatically `initialize` and `apply` the terraform code.

```
$ bash ./terraform_apply.sh
```

The script will automatically sleep for 15sec after all the k8s resources are created, to let them come in ready state, then it will check the connectivity using below command automatically:

```
$ curl `minikube ip`:30007/poi
```

Again you should see results like this:

```
[{"lat":43.6708,"lon":-79.3899,"name":"EQ Works","poi_id":1},{"lat":43.6426,"lon":-79.3871,"name":"CN Tower","poi_id":2},{"lat":43.0896,"lon":-79.0849,"name":"Niagara Falls","poi_id":3},{"lat":49.2965,"lon":-123.0884,"name":"Vancouver Harbour","poi_id":4}]
```

Feel free to use other uri parameters as well instead of `/poi` like `/stats/daily` etc.

When you are done with the testing, cleanup the resources using below command:

```
$ terraform -chdir=./terraform destroy --auto-approve
```

## 4. API performance testing

Having zero experience in this, tried a few things with `JMeter` and I could see that if I hit 5k or more requests simultaneously on the api then it started giving errors regarding service unavailable. To fix that we can distribute the load as per our choice, for example, `for 10k users we should ideally have 3 replicas for api and atleast 2 replicas for db.`

Might need to dig in more to capture other metrics.

