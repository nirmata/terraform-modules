// fetch the EKS cluster values
data "aws_eks_cluster" "cluster" {
  name = var.aws_eks_cluster_name
}


data "kubectl_filename_list" "namespace" {
   pattern = "${nirmata_cluster_registered.eks-registered.controller_yamls_folder}/temp-01-*"
}

data "kubectl_filename_list" "sa" {
   pattern = "${nirmata_cluster_registered.eks-registered.controller_yamls_folder}/temp-02-*"
}

data "kubectl_filename_list" "crd" {
   pattern = "${nirmata_cluster_registered.eks-registered.controller_yamls_folder}/temp-03-*"
}

data "kubectl_filename_list" "deployment" {
   pattern = "${nirmata_cluster_registered.eks-registered.controller_yamls_folder}/temp-04-*"
}