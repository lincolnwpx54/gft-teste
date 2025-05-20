resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-xpto"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aksxpto"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}
