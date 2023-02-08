// Name of aks cluster
variable "aks_cluster_name" {
  default     = "<<AKS cluster name>>"
  description = "AKS Cluster Name"
  type        = string
}

// Azure Resource Group Name
variable "azure_resource_group" {
  default = "<<Azure Resource Group Name>>"
  description = "Azure Resource Group Name"
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
