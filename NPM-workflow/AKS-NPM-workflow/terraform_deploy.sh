#!/bin/bash


#initialize Terraform
terraform init -upgrade
terraform init

#execute Terraform plan for specific target
terraform plan -target module.n4k_module.nirmata_cluster_registered.aks-registered

#apply Terraform changes for specific target and auto-approve
terraform apply -target module.n4k_module.nirmata_cluster_registered.aks-registered --auto-approve


#execute Terraform plan
terraform plan

# Set the maximum number of retries
max_retries=2
retry_count=0

# Retry loop
while [ $retry_count -lt $max_retries ]
do
    echo "Running Terraform apply..."
    terraform apply --auto-approve

    # Check the exit status
    if [ $? -eq 0 ]; then
        echo "Terraform apply successful."
        break
    else
        echo "Terraform apply failed. Retrying..."
        ((retry_count++))
        sleep 5
    fi
done

# Check if the maximum number of retries reached
if [ $retry_count -eq $max_retries ]; then
    echo "Terraform apply failed after $max_retries retries."
fi

