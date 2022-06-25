variable "storage_account_01_location" {
  description = "Region where these resources should be created."
  type        = string
  default     = "eastus"
}

variable "storage_account_01_resource_group_name" {
  description = "The name of the resource group in which resources will be created."
  type        = string
}

variable "storage_account_01_storage_account_name" {
  description = "The name of the Azure Storage account 01."
  type        = string
}

variable "storage_account_01_network_rules" {
  description = "Enables network rules for a Storage Account 01."
  type        = list(object({ default_action = string, bypass = list(string), ip_rules = list(string), subnet_ids = list(string) }))
  default     = []
}

variable "storage_account_01_containers_list" {
  description = "List of containers for storage account 01 to be created and their access levels."
  type        = list(object({ name = string, access_type = string, blobs = list(object({ blob_name = string, type = string, access_tier = string })) }))
  default     = []
}