
locals {
  account_tier             = (var.account_kind == "FileStorage" ? "Premium" : "Standard")
  account_replication_type = (var.account_tier == "Premiun" ? "LRS" : var.account_replication_type)
  container_blobs = flatten([
    for container in var.containers_list : [
      for container_blob in container.blobs : {
        name                   = container_blob.value["blob_name"]
        storage_account_name   = var.storage_account_name
        storage_container_name = container.name
        type                   = container_blob.value["type"]
        access_tier            = container_blob.value["access_tier"]
      }
    ]
  ])
}

resource "azurerm_storage_account" "storageaccount" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = local.account_tier
  access_tier                     = var.access_tier
  account_replication_type        = local.account_replication_type
  min_tls_version                 = var.min_tls_version
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = var.enable_advaned_threat_protection == true ? true : false
  tags                            = merge({ "ResourceName" = var.storage_account_name }, var.tags, )

  identity {
    type = var.assign_identity ? "SystemAssigned" : null #SystemAssigned, UserAssigned, SystemAssigned, UserAssigned
  }

  blob_properties {
    delete_retention_policy {
      days = var.soft_delete_retention
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules != null && length(var.network_rules) > 0 ? ["true"] : []
    content {
      default_action             = network_rule.value["default_action"]
      bypass                     = network_rule.value["bypass"]
      ip_rules                   = network_rule.value["ip_rules"]
      virtual_network_subnet_ids = network_rule.value["subnet_ids"]
    }
  }
}

resource "azurerm_storage_container" "container" {
  count                 = length(var.containers_list)
  name                  = var.containers_list[count.index].name
  storage_account_name  = var.storage_account_name
  container_access_type = var.containers_list[count.index].access_type
}

resource "azurerm_storage_blob" "example" {
  count                  = length(local.container_blobs)
  name                   = local.container_blobs[count.index].name
  storage_account_name   = local.container_blobs[count.index].storage_account_name
  storage_container_name = local.container_blobs[count.index].storage_container_name
  type                   = local.container_blobs[count.index].type
  access_tier            = local.container_blobs[count.index].access_tier
}
