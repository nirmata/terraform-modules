module "n4k_module" {
source              	= "./n4k_module"
aks_cluster_name 	= "<<AKS cluster name>>"
azure_resource_group   	= "<<Azure Resource Group Name>>"
nirmata_api_key	      	= "<<Nirmata API token>>"
imagePullSecret_password = "<<Image pull secret token>>"
nirmata_cluster_name  	= "<<Name of the cluster to be registered in NPM>>"
}
