// fetch the EKS cluster values
data "aws_eks_cluster" "cluster" {
  name = var.aws_eks_cluster_name
}


