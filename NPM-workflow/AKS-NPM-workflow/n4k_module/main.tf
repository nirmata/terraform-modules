// Deploy kyverno-operator

resource "helm_release" "kyverno-operator" {
  name             = "kyverno-operator"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "kyverno-operator"
  namespace        = "nirmata-kyverno-operator"
  create_namespace = true
  force_update     = true
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster
  ]
}

//Install N4K

resource "helm_release" "kyverno" {
  name             = "kyverno"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "kyverno"
  version          = "1.6.1"
  namespace        = "kyverno"
  create_namespace = true
  force_update     = true
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
    helm_release.kyverno-operator
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
  force_update     = true
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
  force_update     = true
  depends_on = [
    data.azurerm_kubernetes_cluster.cluster,
    helm_release.kyverno,
    helm_release.kyverno-operator
  ]
}

data "kubectl_filename_list" "namespace" {
   pattern = "${nirmata_cluster_registered.aks-registered.controller_yamls_folder}/temp-01-*"
}

data "kubectl_filename_list" "crd" {
   pattern = "${nirmata_cluster_registered.aks-registered.controller_yamls_folder}/temp-02-*"
}

data "kubectl_filename_list" "deployment" {
   pattern = "${nirmata_cluster_registered.aks-registered.controller_yamls_folder}/temp-03-*"
}


// Register Nirmata Cluster
resource "nirmata_cluster_registered" "aks-registered" {
  name         = var.nirmata_cluster_name
  cluster_type = var.nirmata_cluster_type
}

// apply the controller YAMLs
resource "kubectl_manifest" "namespace" {
  wait        = true
  count       = nirmata_cluster_registered.aks-registered.controller_ns_yamls_count
  yaml_body   = file(element(data.kubectl_filename_list.namespace.matches, count.index))
  apply_only  = true
}

resource "kubectl_manifest" "crd" {
  wait        = true
  count       = nirmata_cluster_registered.aks-registered.controller_crd_yamls_count
  yaml_body   = file(element(data.kubectl_filename_list.crd.matches, count.index))
  apply_only  = true
  depends_on  = [kubectl_manifest.namespace]
}

resource "kubectl_manifest" "deployment" {
  wait        = true
  count       = nirmata_cluster_registered.aks-registered.controller_deploy_yamls_count
  yaml_body   = file(element(data.kubectl_filename_list.deployment.matches, count.index))
  apply_only  = true
  depends_on  = [kubectl_manifest.crd]
}
