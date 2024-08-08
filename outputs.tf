output "project" {
  description = "The combined details of the created GCP project"
  value = {
    project_id     = google_project.project.project_id
    project_number = google_project.project.number
    project_name   = google_project.project.name
    project_services = {
      for key, service in google_project_service.project_services : key => {
        disable_on_destroy = service.disable_on_destroy
      }
    }
    service_accounts = {
      for key, sa in google_service_account.service_accounts : key => {
        display_name   = sa.display_name
        name           = sa.name
        unique_id      = sa.unique_id
        description    = sa.description
        email          = sa.email
        member         = sa.member
        id             = sa.id
        project_id     = google_project.project.project_id
        project_number = google_project.project.number
      }
    }
    service_agents = {
      for key, sa in google_project_service_identity.service_agents : key => {
        service        = sa.service
        email          = sa.email
        member         = sa.member
        id             = sa.id
        project_id     = google_project.project.project_id
        project_number = google_project.project.number
      }
    }
    consumer_quota_overrides = {
      for key, override in google_service_usage_consumer_quota_override.overrides : key => {
        service        = override.service
        metric         = override.metric
        limit          = override.limit
        override_value = override.override_value
        force          = override.force
      }
    }
  }
}
