// Required terraform providers helm, azure, nimrata, kubernetes and kubectl

// helm provider
provider "helm" {
  kubernetes {
    host = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host

    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  }
}

// aws, nirmata, kubernetes, kubectl providers
terraform {
  required_providers {

    nirmata = {
      source  = "nirmata/nirmata"
      version = "1.1.8-rc2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

# Retrieve AKS cluster information
provider "azurerm" {
  features {}
}


// configure the Nirmata provider
provider "nirmata" {

  // Nirmata address.
  url = "https://nirmata.io"

  // Nirmata API Key. Also configurable using the environment variable NIRMATA_TOKEN.
  token = var.nirmata_api_key
}


// configure the kubectl provider
provider "kubectl" {
  host = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host

  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  apply_retry_count = 15
}
