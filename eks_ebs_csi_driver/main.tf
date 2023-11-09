module "ebs_csi_driver" {
  source = "./ebs-csi-driver"  # Use the relative path to the module directory
  cluster_name = "vikash-tf"
  AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" # ex:- arn:aws:iam::123456789012:policy/AmazonEBSCSIDriverPolicy
  addon_name = "aws-ebs-csi-driver"
  addon_version = "v1.24.1-eksbuild.1"
  aws_region = "us-west-1"
  aws_profile = "default"
}
