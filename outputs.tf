output "project_id" {
  description = "The ID of the created GCP project"
  value       = google_project.project.project_id
}

output "project_number" {
  value = google_project.project.number
}

output "project_name" {
  description = "The name of the created GCP project"
  value       = google_project.project.name
}

output "project_services" {
  description = "Details of the enabled project services"
  value = {
    for key, service in google_project_service.project_services :
    key => {
      service            = service.service
      disable_on_destroy = service.disable_on_destroy
    }
  }
}

output "service_accounts" {
  description = "Details of all created service accounts"
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

