resource "azurerm_log_analytics_workspace" "log_workspace" {
  for_each            = (var.log_workspace_map == null ? {} : var.log_workspace_map)
  name                = each.key
  resource_group_name = each.value.resource_group

  # If location is not defined in resource_group_map, then use "northeurope" as default.
  location          = coalesce(each.value.location, "northeurope")
  sku               = coalesce(each.value.sku, "PerGB2018")
  retention_in_days = coalesce(each.value.retention_in_days, "30")

  tags = merge(local.tf_tags, each.value.custom_tags)
}
