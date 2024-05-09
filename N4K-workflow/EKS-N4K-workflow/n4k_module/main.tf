
//Install N4K Operator

resource "helm_release" "nirmata-kyverno-operator" {
  name             = "kyverno"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "nirmata-kyverno-operator"
  version          = "v0.4.2"
  namespace        = "nirmata-system"
  create_namespace = true
  depends_on = [
    data.aws_eks_cluster.cluster,
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
    value = 2
  }

  set {
    name  = "kyverno.helm.reportsController.replicas"
    value = 2
  }
}

