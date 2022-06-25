# 1. Specify the version of the AzureRM Provider to use.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}

# 2. Configure the AzureRM Provider.
provider "azurerm" {
  features {}
}

# 3. Resource Group Availability.
resource "azurerm_resource_group" "azure_storage_account" {
  name     = var.storage_account_01_resource_group_name
  location = var.storage_account_01_location
}

# 4. Provision Azure Storage Account with Containers.
module "storageacount" {
  source = "./modules/azure-storage-account"

  location             = var.storage_account_01_location
  resource_group_name  = var.storage_account_01_resource_group_name
  storage_account_name = var.storage_account_01_storage_account_name
  network_rules        = var.storage_account_01_network_rules
  containers_list      = var.storage_account_01_containers_list
}