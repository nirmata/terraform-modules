# Nirmata terraform-modules
# A Terraform module for deploying N4K, Policy sets and registering EKS clusters

The terraform module deploys N4K, best practice policy set, and pod security policy set and registers the EKS cluster.

Prerequisites:-

	1. Existing EKS Cluster should be available.
	2. AWS CLI should be configured with EKS Cluster Access.
	3. Existing Nimata Cluster type should be available.

Currently this module is supported to:-

	1. OS:- CentOS, MacOS
	2. Terraform Version:- v1.3.6

## Steps to deploy the terraform module:

```
Make the necessary changes to the main.tf file
```

## Usage:

```
module "n4k_module" {
source                        = "./n4k_module"
eks_cluster_name              = "<<EKS cluster name>>"
nirmata_api_key               = "<<Nirmata API token>>"
licenseKey                    = "<<License key>>"
}

```

```
terraform init
```

```
terraform plan
```

```
terraform apply
```

You should see the EKS cluster, N4K deployed along with all the policy set.

