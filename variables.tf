variable "project_id" {
  description = "The ID for the GCP project. It must be between 6 and 30 characters (including the suffix), can contain lowercase letters, digits, and hyphens, must start with a letter, and cannot end with a hyphen."
  type        = string

  validation {
    condition     = length(var.project_id) >= 2 && length(var.project_id) <= 26 && can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.project_id))
    error_message = "The project ID must be between 6 and 30 characters, including the suffix, and can only contain lowercase letters, digits, and hyphens. It must start with a letter and cannot end with a hyphen."
  }
}

variable "project_name" {
  description = "The name of the GCP project. It must be between 4 and 30 characters, and only contain letters, numbers, single quotes, hyphens, spaces, or exclamation points."
  type        = string

  validation {
    condition     = length(var.project_name) >= 4 && length(var.project_name) <= 30 && can(regex("^[a-zA-Z0-9'\\- !]*$", var.project_name))
    error_message = "The project name must be between 4 and 30 characters, and only contain letters, numbers, single quotes, hyphens, spaces, or exclamation points."
  }
}

variable "folder_id" {
  description = "The folder ID to create the project in. It must be a numeric string."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.folder_id))
    error_message = "The folder ID must be a numeric string."
  }
}

variable "billing_account" {
  description = "The billing account ID. It must be 16 to 20 characters long and can contain uppercase letters, digits, and dashes."
  type        = string

  validation {
    condition     = can(regex("^[A-Z0-9-]{16,20}$", var.billing_account))
    error_message = "The billing account ID must be 16 to 20 characters long and can contain uppercase letters, digits, and dashes."
  }
}

variable "services" {
  description = "List of APIs to enable. Each service must be unique within the list."
  type = list(object({
    service            = string
    disable_on_destroy = optional(bool, false)
  }))
  default = []

  validation {
    condition     = length(distinct([for s in var.services : s.service])) == length(var.services)
    error_message = "Each service in the services list must be unique."
  }
}

variable "service_accounts" {
  description = "List of service accounts to create. Each service account ID must be unique within the list."
  type = list(object({
    account_id  = string
    description = string
  }))
  default = []

  validation {
    condition     = length(distinct([for sa in var.service_accounts : sa.account_id])) == length(var.service_accounts)
    error_message = "Each service account ID in the service_accounts list must be unique."
  }
}

variable "service_agents" {
  description = "List of service agents to create. Each service must be unique within the list."
  type = list(object({
    account_id = string
    service    = string
  }))
  default = []

  validation {
    condition     = length(distinct([for sa in var.service_agents : sa.service])) == length(var.service_agents)
    error_message = "Each service in the service_agents list must be unique."
  }
}

variable "consumer_quota_overrides" {
  description = "A list of consumer quota overrides. Each combination of service and metric must be unique."
  type = list(object({
    service        = string
    metric         = string
    limit          = string
    override_value = number
    force          = optional(bool, true)
  }))
  default = []

  validation {
    condition = alltrue([
      for i in range(length(var.consumer_quota_overrides)) : length([
        for j in range(i + 1, length(var.consumer_quota_overrides)) : true
        if var.consumer_quota_overrides[i].service == var.consumer_quota_overrides[j].service &&
        var.consumer_quota_overrides[i].metric == var.consumer_quota_overrides[j].metric
      ]) == 0
    ])
    error_message = "Duplicate entries found in consumer_quota_overrides. Each combination of service and metric must be unique."
  }
}
