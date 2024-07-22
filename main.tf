terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.38.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.38.0"
    }
  }
}

resource "random_id" "suffix" {
  byte_length = 2
}

resource "google_project" "project" {
  name            = var.project_name
  project_id      = "${var.project_id}-${random_id.suffix.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

resource "google_project_service" "project_services" {
  project  = google_project.project.project_id
  for_each = { for service in var.project_services : service.service => service }

  service            = each.key
  disable_on_destroy = each.value.disable_on_destroy

  depends_on = [google_project.project]
}

resource "google_service_account" "service_accounts" {
  project = google_project.project.project_id

  for_each = { for service in var.project_services : service.service => service if service.create_service_account }

  account_id   = each.value.service_account_id
  display_name = each.value.service_account_description

  depends_on = [google_project.project]
}

resource "google_service_usage_consumer_quota_override" "overrides" {
  for_each       = { for override in var.consumer_quota_overrides : "${override.service}-${override.metric}-${override.limit}" => override }
  project        = var.project_id
  service        = each.value.service
  metric         = urlencode(each.value.metric)
  limit          = urlencode(each.value.limit)
  override_value = each.value.override_value
  force          = each.value.force
  provider       = google-beta
  depends_on     = [google_project.project]
}