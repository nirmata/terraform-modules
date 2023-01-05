module "n4k_module" {
source                   = "./n4k_module"
aks_cluster_name = "vikash-k8s-test"
azure_resource_group = "vikash-k8s-test_group"
nirmata_api_key = "FliSU3DeF5o4LiLPfVBRuxyTyR72/VGzNLfpbPjkHbSnyLXcNmVrte3r58GTsqLxW8VZRYds1peH1+EuSP02+A=="
imagePullSecret_password = "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"
nirmata_cluster_name  = "vikash-k8s-test"
}
