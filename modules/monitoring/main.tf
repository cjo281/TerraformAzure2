#############################################
# Log Analytics Workspace
#############################################

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "lab-logs"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#############################################
# Diagnostic Settings for Target Resource
#############################################

