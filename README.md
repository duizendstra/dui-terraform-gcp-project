# dui-terraform-gcp-project
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.40.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.service_agents](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google-beta_google_service_usage_consumer_quota_override.overrides](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_usage_consumer_quota_override) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_service.project_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.service_accounts](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The billing account ID. It must be 16 to 20 characters long and can contain uppercase letters, digits, and dashes. | `string` | n/a | yes |
| <a name="input_consumer_quota_overrides"></a> [consumer\_quota\_overrides](#input\_consumer\_quota\_overrides) | A list of consumer quota overrides. Each combination of service and metric must be unique. | <pre>list(object({<br>    service        = string<br>    metric         = string<br>    limit          = string<br>    override_value = number<br>    force          = optional(bool, true)<br>  }))</pre> | `[]` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The folder ID to create the project in. It must be a numeric string. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID for the GCP project. It must be between 6 and 30 characters, can contain lowercase letters, digits, and hyphens, must start with a letter, and cannot end with a hyphen. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the GCP project. It must be between 4 and 30 characters, and only contain letters, numbers, single quotes, hyphens, spaces, or exclamation points. | `string` | n/a | yes |
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | List of service accounts to create. Each service account ID must be unique within the list. | <pre>list(object({<br>    account_id  = string<br>    description = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_agents"></a> [service\_agents](#input\_service\_agents) | List of service agents to create. Each service must be unique within the list. | <pre>list(object({<br>    account_id = string<br>    service    = string<br>  }))</pre> | `[]` | no |
| <a name="input_services"></a> [services](#input\_services) | List of APIs to enable. Each service must be unique within the list. | <pre>list(object({<br>    service            = string<br>    disable_on_destroy = optional(bool, false)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project"></a> [project](#output\_project) | The combined details of the created GCP project |
<!-- END_TF_DOCS -->