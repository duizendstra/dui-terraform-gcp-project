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

  billing_account = "0130A2-19B241-AE1341"
  folder_id       = "181031396207"

  project_id   = "dui-module-test"
  project_name = "Module test project"
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
    account_id  = "google-scan"
    description = "your-service-account-description"
  }]

  service_agents = [{
    account_id = "google-scan2"
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


# module "project" {
#   source = "./.." # Adjust the path according to your directory structure

#   billing_account = "your-billing-account-id"
#   folder_id       = "your-folder-id"
#   project_id      = "your-project-id"
#   project_name    = "your-project-name"
#   services = [
#     {
#       service = "logging.googleapis.com"
#     },
#     {
#       service = "secretmanager.googleapis.com"
#     },
#     {
#       service = "artifactregistry.googleapis.com"
#     },
#     {
#       service = "bigquery.googleapis.com"
#     },
#     {
#       service = "cloudbuild.googleapis.com"
#     }
#   ]

#   service_accounts = {
#     service_account_id          = "your-service-account-id"
#     service_account_description = "your-service-account-description"
#   }

#   service_agents = {
#     service = "dataform.googleapis.com"
#   }

#   consumer_quota_overrides = [
#     {
#       service        = "bigquery.googleapis.com"
#       metric         = "bigquery.googleapis.com/quota/query/usage"
#       limit          = "/d/project/user"
#       override_value = 10000
#     },
#   ]
# }

# output "project" {
#   description = "The combined details of the GCP project"
#   value       = module.project.project
# }
