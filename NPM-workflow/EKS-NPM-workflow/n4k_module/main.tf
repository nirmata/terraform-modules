
//Install N4K Operator

resource "helm_release" "nirmata-kyverno-operator" {
  name             = "kyverno"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "nirmata-kyverno-operator"
  version          = "v0.4.2"
  namespace        = "nirmata-system"
  create_namespace = true
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
  ]

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name  = "licenseKey"
    value = var.licenseKey
  }

  set {
    name  = "kyverno.replicaCount"
    value = 3
  }

  set {
    name  = "kyverno.helm.backgroundController.replicas"
    value = 2
  }

  set {
    name  = "kyverno.helm.cleanupController.replicas"
    value = 1
  }

  set {
    name  = "kyverno.helm.reportsController.replicas"
    value = 2
  }
}

// Register Cluster in NPM
resource "nirmata_cluster_registered" "eks-registered" {
  name         = var.nirmata_cluster_name
  cluster_type = var.nirmata_cluster_type
}


// apply the controller YAMLs
resource "kubectl_manifest" "namespace" {
  wait        = true
  count       = nirmata_cluster_registered.eks-registered.controller_ns_yamls_count
  yaml_body   = file(element(data.kubectl_filename_list.namespace.matches, count.index))
  apply_only  = true
  depends_on  = [nirmata_cluster_registered.eks-registered]
}

resource "kubectl_manifest" "sa" {
  wait        = true
  count       = nirmata_cluster_registered.eks-registered.controller_sa_yamls_count
  yaml_body   = file(element(data.kubectl_filename_list.sa.matches, count.index))
  apply_only  = true
  depends_on  = [kubectl_manifest.namespace]
}

resource "kubectl_manifest" "crd" {
  wait        = true
  count       = nirmata_cluster_registered.eks-registered.controller_crd_yamls_count
  yaml_body   = file(element(data.kubectl_filename_list.crd.matches, count.index))
  apply_only  = true
  depends_on  = [kubectl_manifest.sa]
}

resource "kubectl_manifest" "deployment" {
  wait        = true
  count       = nirmata_cluster_registered.eks-registered.controller_deploy_yamls_count
  yaml_body   = file(element(data.kubectl_filename_list.deployment.matches, count.index))
  apply_only  = true
  depends_on  = [kubectl_manifest.crd]
}