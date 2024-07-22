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

module "project" {
  source = "./.."

  billing_account = "your-billing-account-id"
  folder_id       = "your-folder-id"
  project_id      = "your-project-id"
  project_name    = "your-project-name"
  project_services = [
    {
      service = "logging.googleapis.com"
    },
    {
      service = "secretmanager.googleapis.com"
    },
    {
      service = "artifactregistry.googleapis.com"
    },
    {
      service                     = "cloudbuild.googleapis.com"
      create_service_account      = true
      service_account_id          = "cloudbuild-sa"
      service_account_description = "Cloud Build"
    }
  ]
  consumer_quota_overrides = [
    {
      service        = "bigquery.googleapis.com"
      metric         = "bigquery.googleapis.com/quota/query/usage"
      limit          = "/d/project/user"
      override_value = 10000
    },
  ]
}