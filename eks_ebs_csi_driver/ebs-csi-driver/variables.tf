# eks-csi-driver/variables.tf

variable "cluster_name" {
  type        = string
  description = "The name of the AWS EKS cluster"
}

variable "AmazonEBSCSIDriverPolicy" {
  type        = string
  description = "The ARN of the Amazon EBS CSI Driver IAM policy"
}

variable "addon_name" {
  type        = string
  description = "The name of the EKS addon (e.g., aws-ebs-csi-driver)"
  default = "aws-ebs-csi-driver"
}


variable "addon_version" {
  type        = string
  description = "The version of the EKS addon to install (e.g., v1.10.1-eksbuild.1)"
  default     = "v1.10.1-eksbuild.1"  # You can provide a default value or leave it empty if desired
}

# eks-csi-driver/variables.tf

variable "aws_region" {
  type        = string
  description = "The AWS region where the resources will be created."
  default     = "us-west-2"  # Provide a default value or specify it when using the module.
}

variable "aws_profile" {
  type        = string
  description = "The AWS CLI profile to use for authentication."
  default     = "default"  # Provide a default value or specify it when using the module.
}
