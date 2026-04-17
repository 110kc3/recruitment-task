locals {
  name = "app-${var.environment}"
  tags = merge({ Environment = var.environment, ManagedBy = "terraform" }, var.tags)
}

data "azurerm_subnet" "db" {
  name                 = var.db_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                   = "${local.name}-pg"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.db_username
  administrator_password = var.db_password
  delegated_subnet_id    = data.azurerm_subnet.db.id
  private_dns_zone_id    = var.dns_zone_id
  tags                   = local.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.this.id
}
