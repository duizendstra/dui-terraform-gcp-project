variable "project_name" {
  description = "The name of the GCP project"
  type        = string
}

variable "project_id" {
  description = "The ID for the GCP project ID"
  type        = string
}

variable "folder_id" {
  description = "The folder ID to create the project in"
  type        = string
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}

variable "project_services" {
  description = "List of APIs to enable and whether to create service accounts with optional IDs and descriptions"
  type = list(object({
    service                     = string
    disable_on_destroy          = optional(bool, false)
    create_service_account      = optional(bool, false)
    create_service_agent        = optional(bool, false)
    service_account_id          = optional(string)
    service_account_description = optional(string)
  }))
  default = []
}

variable "consumer_quota_overrides" {
  type = list(object({
    service        = string
    metric         = string
    limit          = string
    override_value = number
    force          = optional(bool, true)
  }))
  description = "A list of consumer quota overrides"
  default     = []
}