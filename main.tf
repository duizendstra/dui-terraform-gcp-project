terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.40.0"
    }
  }
}

# Generates a random suffix to ensure the uniqueness of the project ID
resource "random_id" "suffix" {
  byte_length = 2
}

# Creates a new Google Cloud Platform (GCP) project with a unique ID
resource "google_project" "project" {
  name            = var.project_name
  project_id      = "${var.project_id}-${random_id.suffix.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

# Enables the specified Google APIs/services for the created project
resource "google_project_service" "project_services" {
  project  = google_project.project.project_id
  for_each = { for service in var.services : service.service => service }

  service            = each.key
  disable_on_destroy = each.value.disable_on_destroy

  depends_on = [google_project.project]
}

# Creates service accounts within the GCP project
resource "google_service_account" "service_accounts" {
  project  = google_project.project.project_id
  for_each = { for service_account in var.service_accounts : service_account.account_id => service_account }

  account_id   = each.value.account_id
  display_name = each.value.description

  depends_on = [google_project.project]
}

# Creates service identities (service agents) for specific Google services within the project
resource "google_project_service_identity" "service_agents" {
  provider = google-beta
  project  = google_project.project.project_id
  for_each = { for service_agent in var.service_agents : service_agent.account_id => service_agent }

  service = each.value.service

  depends_on = [google_project.project]
}

# Applies consumer quota overrides for specific services and metrics in the project
resource "google_service_usage_consumer_quota_override" "overrides" {
  for_each       = { for override in var.consumer_quota_overrides : "${override.service}-${override.metric}-${override.limit}" => override }
  project        = google_project.project.project_id
  service        = each.value.service
  metric         = urlencode(each.value.metric)
  limit          = urlencode(each.value.limit)
  override_value = each.value.override_value
  force          = each.value.force

  provider   = google-beta
  depends_on = [google_project.project]
}
