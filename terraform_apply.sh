#!/bin/bash

echo -e "Initializing and applying terraform manifests...make sure you have terraform command installed and available in your PATH\n"

terraform -chdir=./terraform init 
terraform -chdir=./terraform apply --auto-approve
