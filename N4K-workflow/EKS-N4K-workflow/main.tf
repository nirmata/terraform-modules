module "n4k_module" {
  source                   = "./n4k_module"
  aws_eks_cluster_name     = "<<AWS EKS cluster name>>"
  nirmata_api_key          = "<<Nirmata API token>>"
  licenseKey               = "<<License key>>"
}
