// Required terraform providers helm, aws, nimrata, kubernetes and kubectl

// helm provider
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      # api_version = "client.authentication.k8s.io/v1alpha1"
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

// aws, nirmata, kubernetes, kubectl providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

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

// configure the Nirmata provider
provider "nirmata" {

  // Nirmata address.
  url = "https://nirmata.io"

  // Nirmata API Key. Also configurable using the environment variable NIRMATA_TOKEN.
  token = var.nirmata_api_key
}


// configure the kubectl provider
provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}

