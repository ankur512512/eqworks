#!/bin/bash

echo -e "\nInitializing and applying terraform manifests...make sure you have terraform command installed and available in your PATH\n"

terraform -chdir=./terraform init 

echo -e "\nTerraform initialized. Now running terraform apply..."

terraform -chdir=./terraform apply --auto-approve

echo -e "\nSleeping for 15 seconds for your resources to get ready.\n"
sleep 15

echo -e "\nYour minikube ip you can use to access NodePort service is: `minikube ip`"

echo -e "\nNow running curl command on: `minikube ip`:30007/poi to check the connectivity for api and db service...\n"

curl `minikube ip`:30007/poi
