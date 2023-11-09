# eks-csi-driver/main.tf

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
