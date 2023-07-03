#!/bin/bash

#function to handle interrupt signal
interrupt_handler() {
echo "Script interrupted by user."
exit 1
}

#trap interrupt signal
trap interrupt_handler SIGINT

#initialize Terraform
terraform init -upgrade
terraform init

#execute Terraform plan for specific target
terraform plan -target module.n4k_module.nirmata_cluster_registered.aks-registered

#apply Terraform changes for specific target and auto-approve
terraform apply -target module.n4k_module.nirmata_cluster_registered.aks-registered --auto-approve


#execute Terraform plan
terraform plan

#apply all Terraform changes and auto-approve
terraform apply --auto-approve

#check if exit status is not 0, retry Terraform apply
while [ $? -ne 0 ]
do
echo "Terraform apply failed. Retrying..."
sleep 5

terraform apply --auto-approve
done
echo "Terraform apply successful."
