variable "resource_group_name" {
  description = "The name of the resource group in which resources will be created."
  type        = string
}

variable "location" {
  description = "Region where these resources should be created."
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "The name of the Azure Storage account"
  type        = string
}

variable "account_kind" {
  description = "The type of the Storage Account. Available values are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2(default)."
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  description = "The account tier for Storage Account. Available values are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium."
  type        = string
  default     = "Standard"
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Archive, Hot and Cool, defaults to Hot."
  type        = string
  default     = "Hot"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
  type        = string
  default     = "LRS"
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1 and TLS1_2"
  type        = string
  default     = "TLS1_2"
}

variable "enable_advaned_threat_protection" {
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true"
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "assign_identity" {
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
  default     = true
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together. Default is 7."
  default     = 7
}

variable "network_rules" {
  description = "Enables network rules for a Storage Account. default_action can be Allow or Deny"
  type        = list(object({ default_action = string, bypass = list(string), ip_rules = list(string), subnet_ids = list(string) }))
}

variable "containers_list" {
  description = "List of containers to be created and their access levels. Each container contains blobs, if provided a blob(of type folder) will be created. Available types in azurerm_storage_blob are Append, Block or Page. Available access_tier values are Archive, Cool and Hot."
  type        = list(object({ name = string, access_type = string, blobs = list(object({ blob_name = string, type = string, access_tier = string })) }))
}
