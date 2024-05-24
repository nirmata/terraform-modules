# A Terraform module for deploying N4K, Policy sets and registering AKS clusters

The terraform module deploys N4K, best practice policy set, and pod security policy set and registers the AKS cluster.

Note:- To deploy the kyverno:-

	 v1.8.5 use the v1.8.5 branch.
 	 v1.9.1 use the v1.9.1 branch.

Prerequisites:-

	1. Existing AKS Cluster should be available.
	2. Azure CLI should be configured with AKS Cluster Access.
	3. Existing Nimata Cluster type should be available.

Currently this module is supported to:-

	1. OS:- CentOS, MacOS
	2. Terraform Version:- v1.3.6

## Prior Azure command to execute for authenticating Terraform with Azure Provider

Creating an Service Principal

```
az login
```

```
az ad sp create-for-rbac --name <name-for-service-principal> --role Contributor --scopes /subscriptions/baf89069-e8f3-46f8-b74e-c146931ce7a4
```

After running the above command, you will get a JSON output that includes:

- appId: This is your client_id.
- password: This is your client_secret.
- tenant: This is your tenant_id.

	```
	Creating 'Contributor' role assignment under scope '/subscriptions/baf89069-e8f3-46f8-b74e-c146931ce7a4'
	The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
	{
	"appId": "2a24c481-d776-4671-9ffb-096ffff0d335",
	"displayName": "terraform-demo-sp",
	"password": "***********",
	"tenant": "3d95acd6-b6ee-428e-a7a0-196120fc3c65"
	}
	```

	Further add the values of **appId** section and **password** section to **client_id** and **client_secret** present in [terraform.tf.vars](./terraform.tfvars)

	Alternatively, you can set environment variables:

	```
	export ARM_CLIENT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	export ARM_CLIENT_SECRET="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	export ARM_TENANT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	export ARM_SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	```

At this point running either ***terraform plan** or **terraform apply** should allow Terraform to authenticate using the Client Secret.

## Steps to deploy the terraform module:

```
Make the necessary changes to the main.tf file
```

## Usage:

```
module "n4k_module" {
source                        = "./n4k_module"
aks_cluster_name              = "<<AKS cluster name>>"
azure_resource_group          = "<<Azure Resource Group Name>>"
nirmata_api_key               = "<<Nirmata API token>>"
licenseKey                    = "<<License key>>"
nirmata_cluster_name          = "<<Name of the nirmata cluster to be registered>>"
nirmata_cluster_type          = "<<Name of the nirmata cluster type>>"
}

```

```
terraform init
```

```
terraform plan -target module.n4k_module.nirmata_cluster_registered.aks-registered
```

```
terraform apply -target module.n4k_module.nirmata_cluster_registered.aks-registered
```

```
terraform plan
```

```
terraform apply
```

You should see the AKS cluster registered in NPM and N4K deployed along with all the policy set.

