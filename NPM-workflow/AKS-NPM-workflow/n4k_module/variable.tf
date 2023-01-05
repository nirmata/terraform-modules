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

variable "nirmata_api_key" {
  default     = "<<Nirmata API token>>"
  description = "Nirmata API Key"
  type        = string
  sensitive   = true
}

variable "imagePullSecret_password" {
  default     = "<<Image pull secret token>>"
  description = "Image Pull Secret password"
  sensitive   = true
}

// Name of Nirmata cluster
variable "nirmata_cluster_name" {
  default     = "<<Name of the cluster to be registered in NPM>>"
  description = "Nirmata Cluster Name"
  type        = string
}
