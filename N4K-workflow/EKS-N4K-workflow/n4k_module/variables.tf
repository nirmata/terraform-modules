// Name of aws eks cluster
variable "aws_eks_cluster_name" {
  description = "AWS EKS Cluster Name"
  type        = string
}


// Nirmata API Key
variable "nirmata_api_key" {
  description = "Nirmata API Key"
  type        = string
  sensitive   = true
}

// Value of license key
variable "licenseKey" {
  description = "Value of license key"
  type        = string
  sensitive   = true
}

