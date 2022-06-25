module "storage" {
    source = "../.."
    location = "eastus"
    resource_group_name= "TestResourceGroup"
    storage_account_name = "TestStorageAccount"
    network_rules = [{
        default_action = "Allow", bypass = [], ip_rules = ["199.65.55.0/24"], subnet_ids = ["/subscriptions/<subscriptionid>/resourceGroups/MyResourceGroup/Microsoft.Network/virtualNetworks/MyNetwork/subnets/MySubnet"]
    }]
    containers_list = [
        {name = "testcontainer", access_type = "private", blobs = [
            { blob_name = "Folder1", type = "Block" }
        ]}
    ]
}

output "sorage_account_name" {
    value = module.storage.storage_acount_name
}