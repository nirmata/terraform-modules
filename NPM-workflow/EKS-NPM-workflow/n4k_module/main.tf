//Install N4K

resource "helm_release" "kyverno" {
  name             = "kyverno"
  repository       = "https://nirmata.github.io/kyverno-charts"
  chart            = "kyverno"
  namespace        = "kyverno"
  create_namespace = true

  set {
    name  = "image.pullSecrets.username"
    value = "nirmata-enterprise-for-kyverno"
  }

  set {
    name  = "image.pullSecrets.password"
    value = var.imagePullSecret_password
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
    data.aws_eks_cluster.cluster,
    helm_release.kyverno
  ]


  set {
    name  = "imagePullSecret.username"
    value = "nirmata-enterprise-for-kyverno"
  }

  set {
    name  = "imagePullSecret.password"
    value = var.imagePullSecret_password
  }
}

//Deploy best-practise policies

resource "helm_release" "best-practice-policies" {
  name       = "best-practice-policies"
  repository = "https://nirmata.github.io/kyverno-charts"
  chart      = "best-practice-policies"
  depends_on = [
    data.aws_eks_cluster.cluster,
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
    data.aws_eks_cluster.cluster,
    helm_release.kyverno,
    helm_release.kyverno-operator
  ]
}

// Register Cluster in NPM
resource "nirmata_cluster_registered" "eks-registered" {
  name         = var.nirmata_cluster_name
  cluster_type = "default-policy-manager-type"
}

resource "kubectl_manifest" "test" {
  count     = nirmata_cluster_registered.eks-registered.controller_yamls_count
  yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}
