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

variable "licenseKey" {
  description = "Value of license key"
  type        = string
  sensitive   = true
}


// Name of Nirmata cluster
variable "nirmata_cluster_name" {
  description = "Nirmata Cluster Name"
  type        = string
}
