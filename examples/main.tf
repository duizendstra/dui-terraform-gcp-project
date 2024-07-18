module "project" {
  source          = "./.."
  folder_id       = "my-folder-id"
  billing_account = "my-project-id"
  project_id      = "terraform-test"
  project_name    = "Terraform test"
  apis = [{
    service                = "secretmanager.googleapis.com"
    create_service_account = true
  }]
}

output "created_project_id" {
  value = module.project.project_id
}

output "created_project_number" {
  value = module.project.project_number
}

output "created_project_name" {
  value = module.project.project_name
}

output "created_service_account_emails" {
  value = module.project.service_account_emails
}

output "created_service_account_ids" {
  value = module.project.service_account_ids
}
