variable "client_id" {
  description = "The client ID for the Azure Service Principal"
}

variable "client_secret" {
  description = "The client secret for the Azure Service Principal"
  sensitive = true
}

variable "tenant_id" {
  description = "The tenant ID for the Azure Service Principal"
}

variable "subscription_id" {
  description = "The subscription ID for the Azure Service Principal"
}
