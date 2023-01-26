//Install N4K

resource "helm_release" "kyverno" {
  name             = "kyverno"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "kyverno"
  namespace        = "kyverno"
  create_namespace = true

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

// Deploy kyverno-operator

resource "helm_release" "kyverno-operator" {
  name             = "kyverno-operator"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "kyverno-operator"
  namespace        = "nirmata-kyverno-operator"
  create_namespace = true
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
    helm_release.kyverno
  ]
}

//Deploy best-practise policies

resource "helm_release" "best-practice-policies" {
  name       = "best-practice-policies"
  repository = "https://nirmata.github.io/kyverno-charts"
  chart      = "best-practice-policies"
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
    helm_release.kyverno,
    helm_release.kyverno-operator
  ]
}

//Deploy pod security polcices

resource "helm_release" "pod-security-policies" {
  name       = "pod-security-policies"
  repository = "https://nirmata.github.io/kyverno-charts"
  chart      = "pod-security-policies"
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
    helm_release.kyverno,
    helm_release.kyverno-operator
  ]
}

// Register Cluster in NPM
resource "nirmata_cluster_registered" "aks-registered" {
  name         = var.aks_cluster_name
  cluster_type = "default-policy-manager-type"
}

// apply the controller YAMLs
resource "kubectl_manifest" "test" {
  count     = nirmata_cluster_registered.aks-registered.controller_yamls_count
  yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}
