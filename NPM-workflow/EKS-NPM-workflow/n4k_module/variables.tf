// Name of aws eks cluster
variable "aws_eks_cluster_name" {
  description = "AWS EKS Cluster Name"
  type        = string
}

variable "nirmata_api_key" {
  description = "Nirmata API Key"
  type        = string
  sensitive   = true
}


variable "imagePullSecret_password" {
  description = "Image Pull Secret password"
  sensitive   = true
}

// Name of Nirmata cluster
variable "nirmata_cluster_name" {
  description = "Nirmata Cluster Name"
  type        = string
}

