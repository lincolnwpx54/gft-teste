resource "azurerm_log_analytics_workspace" "logs" {
  name                = "log-xpto"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "aks_logs" {
  name               = "aks-diag"
  target_resource_id = var.aks_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id

  log {
    category = "kube-apiserver"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}
