// fetch the EKS cluster values
data "aws_eks_cluster" "cluster" {
  name = var.aws_eks_cluster_name
}

// fetch the nimrata controller yaml
data "kubectl_filename_list" "manifests" {
  pattern = "${nirmata_cluster_registered.eks-registered.controller_yamls_folder}/*"
}
