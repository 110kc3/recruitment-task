output "db_endpoint" { value = azurerm_postgresql_flexible_server.this.fqdn }
output "db_port"     { value = 5432 }
output "db_name"     { value = azurerm_postgresql_flexible_server_database.this.name }
output "db_username" { value = azurerm_postgresql_flexible_server.this.administrator_login }
