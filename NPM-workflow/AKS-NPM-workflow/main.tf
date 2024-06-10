module "n4k_module" {
source                        = "./n4k_module"
aks_cluster_name              = "<<AKS cluster name>>"
azure_resource_group          = "<<Azure Resource Group Name>>"
nirmata_api_key               = "<<Nirmata API token>>"
licenseKey                    = "<<License key>>"
nirmata_cluster_name          = "<<Name of the nirmata cluster to be registered>>"
nirmata_cluster_type          = "<<Name of the nirmata cluster type>>"
}

provider "azurerm" {
  features {}

  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
  
}