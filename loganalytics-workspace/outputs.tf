output "log_workspace_list" {
  description = "Returns a list of names of log analytics workspace(s) created/deleted"
  depends_on  = [azurerm_log_analytics_workspace.log_workspace]

  value = [
    for workspace in keys(azurerm_log_analytics_workspace.log_workspace) :
    azurerm_log_analytics_workspace.log_workspace[workspace].name
  ]
}

output "team_name" {
  value = var.team_name
}
