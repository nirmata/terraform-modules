# A Terraform module for deploying N4K, Policy sets and registering AKS clusters

The terraform module deploys N4K, best practice policy set, and pod security policy set and registers the AKS cluster.

Prerequisites:-

	1. Existing AKS Cluster should be available.
	2. Azure CLI should be configured with AKS Cluster Access.
        3. Existing Nimata Cluster type should be available.

Note:- Currently this module is supported to:-

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
aks_cluster_name              = "<<AKS cluster name>>"
azure_resource_group          = "<<Azure Resource Group Name>>"
nirmata_api_key               = "<<Nirmata API token>>"
licenseKey                    = "<<License key>>"
nirmata_cluster_name          = "<<Name of the nirmata cluster to be registered>>"
nirmata_cluster_type          = "<<Name of the nirmata cluster type>>"
}

```

```
terraform init
```

```
terraform plan -target module.n4k_module.nirmata_cluster_registered.aks-registered
```

```
terraform apply -target module.n4k_module.nirmata_cluster_registered.aks-registered
```

```
terraform plan
```

```
terraform apply
```

You should see the AKS cluster registered in NPM and N4K deployed along with all the policy set.

