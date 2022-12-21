# A Terraform module for deploying N4K, Policy sets and registering EKS clusters in NPM

The terraform module deploys N4K, best practice policy set, and pod security policy set and registers the EKS cluster with NPM.

## Usage:

```
module "n4k_module" {
source                   = "./n4k_module"
aws_eks_cluster_name     = "<<AWS EKS cluster name>>"
nirmata_api_key          = "<<Nirmata API token>>"
imagePullSecret_password = "<<Image pull secret token>>"
nirmata_cluster_name     = "<<Name of the cluster to be registered in NPM>>"
}
```

Steps to deploy the terraform module:

```
terraform init
```

```
terraform plan -target module.n4k_module.nirmata_cluster_registered.eks-registered
```

```
terraform apply -target module.n4k_module.nirmata_cluster_registered.eks-registered
```

```
terraform plan
```

```
terraform apply
```

You should see the cluster registered in NPM and N4K deployed along with all the policy set.
