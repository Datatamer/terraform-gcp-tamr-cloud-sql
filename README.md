<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0, <6.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | > 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.0, <6.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | > 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_service.enable_sql](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_sql_database.tamr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.tamr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.sql_dev_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_password.sql_tamr_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | name of the cloud sql instance to create | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | the project to create the sql instance in | `string` | n/a | yes |
| <a name="input_activation_policy"></a> [activation\_policy](#input\_activation\_policy) | This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON\_DEMAND | `string` | `"ALWAYS"` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | True if backup configuration is enabled. | `bool` | `true` | no |
| <a name="input_backup_point_in_time_recovery_enabled"></a> [backup\_point\_in\_time\_recovery\_enabled](#input\_backup\_point\_in\_time\_recovery\_enabled) | True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation. | `bool` | `true` | no |
| <a name="input_backup_start_time"></a> [backup\_start\_time](#input\_backup\_start\_time) | HH:MM format time indicating when backup configuration starts. | `string` | `"06:00"` | no |
| <a name="input_cloudsql_availability_type"></a> [cloudsql\_availability\_type](#input\_cloudsql\_availability\_type) | The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL). | `string` | `"REGIONAL"` | no |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags) | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | name of the database | `string` | `"doit"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Set deletion protection on Cloud SQL instance. Setting this will protect instances from accidental deletion across all surfaces (API, gcloud, Cloud Console and Terraform). | `bool` | `true` | no |
| <a name="input_disk_autoresize"></a> [disk\_autoresize](#input\_disk\_autoresize) | Enable disk to autoresize itself | `bool` | `true` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | size of the disk to use | `number` | `100` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | The disk type to use on the instance. should be either PD\_SSD or PD\_STANDARD | `string` | `"PD_SSD"` | no |
| <a name="input_enable_private_ip"></a> [enable\_private\_ip](#input\_enable\_private\_ip) | Whether this instance should use a public or private ip address | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | labels to be attached to the resources created | `map(string)` | `{}` | no |
| <a name="input_private_network_id"></a> [private\_network\_id](#input\_private\_network\_id) | The VPC network from which the Cloud SQL instance is accessible for private IP | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region for the instance | `string` | `"us-east1"` | no |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Set if SSL is required for the Cloud SQL instance. | `bool` | `false` | no |
| <a name="input_ssl_mode"></a> [ssl\_mode](#input\_ssl\_mode) | Set up the SSL mode. If SSL is required, this value is TRUSTED\_CLIENT\_CERTIFICATE\_REQUIRED. | `string` | `"ALLOW_UNENCRYPTED_AND_ENCRYPTED"` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | the machine type to use for the sql instance | `string` | `"db-custom-1-3840"` | no |
| <a name="input_postgres_version"></a> [tier](#input\_postgres\_version) | Version of Postgres to install on the CloudSQL instance | `string` | `"POSTGRES_12"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | n/a |
| <a name="output_tamr_password"></a> [tamr\_password](#output\_tamr\_password) | n/a |
| <a name="output_uri"></a> [uri](#output\_uri) | n/a |
<!-- END_TF_DOCS -->
