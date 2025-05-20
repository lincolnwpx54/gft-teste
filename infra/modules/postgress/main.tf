resource "azurerm_postgresql_flexible_server" "db" {
  name                   = "pg-xpto-db"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = "adminuser"
  administrator_password = var.db_password
  sku_name               = "Standard_B1ms"
  version                = "14"
  storage_mb             = 32768
  zone                   = "1"

  high_availability {
    mode = "ZoneRedundant"
  }

  authentication {
    active_directory_auth_enabled = false
    password_auth_enabled         = true
  }

  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = null
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name                = "allow-vnet"
  server_name         = azurerm_postgresql_flexible_server.db.name
  resource_group_name = var.resource_group_name
  start_ip_address    = "10.0.0.0"
  end_ip_address      = "10.0.255.255"
}
