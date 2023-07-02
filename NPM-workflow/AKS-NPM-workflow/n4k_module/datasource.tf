// fetch the AKS cluster values
data "azurerm_kubernetes_cluster" "cluster" {
  name                = var.aks_cluster_name
  resource_group_name = var.azure_resource_group
}

// fetch the nimrata controller yaml

data "kubectl_filename_list" "namespace" {
   pattern = "${nirmata_cluster_registered.aks-registered.controller_yamls_folder}/temp-01-*"
}

data "kubectl_filename_list" "crd" {
   pattern = "${nirmata_cluster_registered.aks-registered.controller_yamls_folder}/temp-02-*"
}

data "kubectl_filename_list" "deployment" {
   pattern = "${nirmata_cluster_registered.aks-registered.controller_yamls_folder}/temp-03-*"
}
