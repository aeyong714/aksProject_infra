provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "aksProject"
  location = "East Asia"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKS"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "aks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
