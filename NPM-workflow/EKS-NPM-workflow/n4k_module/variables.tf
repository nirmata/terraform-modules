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

// Name of Nirmata cluster
variable "nirmata_cluster_name" {
  default     = "<<Name of the nirmata cluster>>"
  description = "Value of Nirmata Cluster Name"
  type        = string
}

// Value of Nirmata cluster type
variable "nirmata_cluster_type" {
  default     = "<<Name of the nirmata cluster type>>"
  description = "Value of Nirmata Cluster type"
  type        = string
}
