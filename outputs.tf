# Define the resource for consumer quota overrides
output "project" {
  description = "The combined details of the created GCP project"
  value = {
    project_id = google_project.project.project_id
    project_number = google_project.project.number
    project_name = google_project.project.name
    project_services = {
      for key, service in google_project_service.project_services :
      key => {
        service = service.service
        disable_on_destroy = service.disable_on_destroy
      }
    }
    service_accounts = {
      for sa in google_service_account.service_accounts :
      sa.account_id => {
        account_id = sa.account_id
        display_name = sa.display_name
        email = sa.email
        name = sa.name
        unique_id = sa.unique_id
      }
    }
    consumer_quota_overrides = {
      for key, override in google_service_usage_consumer_quota_override.overrides :
      key => {
        service        = override.service
        metric         = override.metric
        limit          = override.limit
        override_value = override.override_value
        force          = override.force
      }
    }
  }
}

# Deprecated outputs
output "project_id" {
  description = "(DEPRECATED) The ID of the created GCP project. Use 'new_project_id' instead."
  value       = google_project.project.project_id
}

output "project_number" {
  description = "(DEPRECATED) The number of the created GCP project. Use 'new_project_number' instead."
  value       = google_project.project.number
}

output "project_name" {
  description = "(DEPRECATED) The name of the created GCP project. Use 'new_project_name' instead."
  value       = google_project.project.name
}

output "project_services" {
  description = "(DEPRECATED) Details of the enabled project services. Use 'new_project_services' instead."
  value = {
    for key, service in google_project_service.project_services :
    key => {
      service            = service.service
      disable_on_destroy = service.disable_on_destroy
    }
  }
}

output "service_accounts" {
  description = "(DEPRECATED) Details of all created service accounts. Use 'new_service_accounts' instead."
  value = {
    for key, sa in google_service_account.service_accounts :
    key => {
      account_id   = sa.account_id
      display_name = sa.display_name
      email        = sa.email
      name         = sa.name
      project      = sa.project
      unique_id    = sa.unique_id
    }
  }
}
