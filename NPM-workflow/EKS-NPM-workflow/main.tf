module "n4k_module" {
source                   = "./n4k_module"
aws_eks_cluster_name     = "<<AWS EKS cluster name>>"
nirmata_api_key          = "<<Nirmata API token>>"
imagePullSecret_password = "<<Image pull secret token>>"
nirmata_cluster_name     = "<<Name of the cluster to be registered in NPM>>"
}
