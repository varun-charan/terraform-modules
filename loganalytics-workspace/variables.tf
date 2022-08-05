variable "env" {
  type        = string
  default     = "dev"
  description = "Azure region for deployment of resources."
}

# Define the team_name for the resource group(s).
variable "team_name" {
  description = "(Required) String denoting the team responsible for the resource group."
  type        = string

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("devops", var.team_name))
    error_message = "Invalid Team Name. Team name must be one of these: devops ."
  }
}

# Define a map that contains resource group names as key and a map of location and custom_tags as values.
variable "log_workspace_map" {
  type = map(object({
    location                    = string
    resource_group              = string
    retention_in_days           = string
    sku                         = string
    custom_tags                 = map(string)
    validate_log_workspace_name = bool
  }))

  description = "(Required) Map of log analytics workspaces and their details."

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can([for key, value in var.log_workspace_map : regex("([0-9A-Za-z-]+)-(sandbox|dev|uat|stg|prd)-?.*-workspace", key) if value.validate_log_workspace_name])
    error_message = "Check names of all log-analytics workspaces for this team. \nThe log analytics workspace name MUST BE in the pattern: <TEAM_NAME>-<sandbox/dev/uat/stg/prd>-<FREEFORM, if required>-rg  . \nFor e.g., devops-dev-00-workspace, devops-dev-01-workspace, devops-stg-00-iothub-rg, etc."
  }
}