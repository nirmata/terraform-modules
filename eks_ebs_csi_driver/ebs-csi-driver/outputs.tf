# eks-csi-driver/outputs.tf

output "example_eks_cluster_id" {
  value = data.aws_eks_cluster.example.id
}

output "example_iam_role_id" {
  value = aws_iam_role.example.id
}
