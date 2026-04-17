location            = "westeurope"
resource_group_name = "app-prd-rg"
vnet_name           = "app-prd-vnet"
db_subnet_name      = "db-subnet"
dns_zone_id         = "/subscriptions/EDIT_SUB_ID/resourceGroups/EDIT_RG/providers/Microsoft.Network/privateDnsZones/privatelink.sth"
db_name             = "appdb"
db_username         = "appadmin"
tags                = { Tier = "prod" }
