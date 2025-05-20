resource "azurerm_redis_cache" "redis" {
  name                = "redis-xpto-cache"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = false

  redis_configuration {
    maxmemory_policy = "allkeys-lru"
  }

  subnet_id     = var.subnet_id
  minimum_tls_version = "1.2"
}
