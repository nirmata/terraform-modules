
//Install N4K

resource "helm_release" "kyverno" {
  name             = "kyverno"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "kyverno"
  version          = "1.6.1"
  namespace        = "kyverno"
  create_namespace = true
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
  ]

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name  = "licenseManager.licenseKey"
    value = var.licenseKey
  }

  set {
    name  = "podDisruptionBudget.minAvailable"
    value = 1
  }

  set {
    name  = "replicaCount"
    value = 3
  }
}

//Deploy best-practise policies

resource "helm_release" "best-practice-policies" {
  name       = "best-practice-policies"
  repository = "https://nirmata.github.io/kyverno-charts"
  chart      = "best-practice-policies"
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
    helm_release.kyverno
  ]
}

//Deploy pod security polcices

resource "helm_release" "pod-security-policies" {
  name       = "pod-security-policies"
  repository = "https://nirmata.github.io/kyverno-charts"
  chart      = "pod-security-policies"
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
    helm_release.kyverno
  ]
}

// Register Nirmata Cluster
resource "nirmata_cluster_registered" "aks-registered" {
  name         = var.nirmata_cluster_name
  cluster_type = var.nirmata_cluster_type
}

// apply the controller YAMLs
resource "kubectl_manifest" "test" {
  count     = nirmata_cluster_registered.aks-registered.controller_yamls_count
  yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
  apply_only = true
}
