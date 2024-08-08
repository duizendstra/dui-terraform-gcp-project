terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.40.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.40.0"
    }
  }
}

module "project" {
  source = "./.." # Adjust the path according to your directory structure

  billing_account = "your-billing-account-id"
  folder_id       = "your-folder-id"
  project_id      = "your-project-id"
  project_name    = "your-project-name"
  services = [
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
      service = "bigquery.googleapis.com"
    },
    {
      service = "cloudbuild.googleapis.com"
    }
  ]

  service_accounts = [{
    account_id  = "sa1"
    description = "your-service-account-description"
  }]

  service_agents = [{
    account_id = "sa2"
    service    = "dataform.googleapis.com"
  }]

  consumer_quota_overrides = [
    {
      service        = "bigquery.googleapis.com"
      metric         = "bigquery.googleapis.com/quota/query/usage"
      limit          = "/d/project/user"
      override_value = 10000
    },
  ]
}

output "project" {
  description = "The combined details of the GCP project"
  value       = module.project.project
}
