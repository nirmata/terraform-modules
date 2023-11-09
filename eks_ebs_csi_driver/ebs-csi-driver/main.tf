resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.example.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "example" {
  assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
  name               = "example-ebs-csi-role"
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = var.AmazonEBSCSIDriverPolicy
  role       = aws_iam_role.example.name
}

resource "aws_eks_addon" "example" {
  cluster_name                = var.cluster_name
  addon_name                  = var.addon_name
  service_account_role_arn    = aws_iam_role.example.arn
  addon_version               = var.addon_version # Update this as needed
  resolve_conflicts_on_update = "PRESERVE"
}
