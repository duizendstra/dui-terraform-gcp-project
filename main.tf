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

resource "google_project" "main" {
  name            = var.project_name
  project_id      = "${var.project_id}-${random_id.suffix.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

resource "google_project_service" "project_services" {
  for_each           = { for api in var.apis : api.service => api }
  project            = google_project.main.project_id
  service            = each.key
  disable_on_destroy = false

  depends_on = [google_project.main]
}

resource "google_service_account" "service_accounts" {
  for_each = { for api in var.apis : api.service => api if api.create_service_account }

  account_id   = "${split(".", each.value.service)[0]}-sa"
  display_name = "Service account for ${split(".", each.value.service)[0]}"
  project      = google_project.main.project_id
}

