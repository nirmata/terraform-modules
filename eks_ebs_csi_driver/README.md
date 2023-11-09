# Terraform EBS CSI Driver Module

This Terraform module installs the AWS Elastic Block Store (EBS) Container Storage Interface (CSI) Driver as an addon on an existing AWS EKS cluster.

## Prerequisites

Before using this module, ensure you have the following:

- An existing AWS EKS cluster
- An IAM policy ARN for the Amazon EBS CSI Driver
- AWS credentials configured in your environment with appropriate permissions

## Usage

1. **Module Configuration:**

   Update the `main.tf` file in the module directory with the necessary input values:

   ```hcl
   module "ebs_csi_driver" {
     source            = "./ebs-csi-driver"
     cluster_name      = "<cluster_name_value>"
     AmazonEBSCSIDriverPolicy = "<AmazonEBSCSIDriverPolicy_arn_value>"
     addon_name        = "aws-ebs-csi-driver"
     addon_version     = "v1.24.1-eksbuild.1"
     aws_region        = "<aws_eks_cluster_region>"
     aws_profile       = "<aws_profile_name>"
   }
   ```

2. **Module Variables:**

   Update the variable values in the `variables.tf` file as needed:

   - `cluster_name`: The name of the AWS EKS cluster.
   - `AmazonEBSCSIDriverPolicy`: The ARN of the Amazon EBS CSI Driver IAM policy.
   - `addon_name`: The name of the EKS addon (default is "aws-ebs-csi-driver").
   - `addon_version`: The version of the EKS addon to install (default is "v1.24.1-eksbuild.1").
   - `aws_region`: The AWS region where the resources will be created (default is "us-west-2").
   - `aws_profile`: The AWS CLI profile to use for authentication (default is "default").

3. **Terraform Initialization:**

   In the root directory of your Terraform configuration, run:

   ```bash
   terraform init
   ```

4. **Terraform Apply:**

   Apply the changes to create the resources:

   ```bash
   terraform apply
   ```

## Authors

- [Vikash Kaushik](https://github.com/vikashkaushik01)

