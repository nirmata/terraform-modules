// fetch the AKS cluster values
data "azurerm_kubernetes_cluster" "cluster" {
  name                = var.aks_cluster_name
  resource_group_name = var.azure_resource_group
}
