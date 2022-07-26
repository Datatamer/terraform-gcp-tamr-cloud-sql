# Terraform Google Cloud SQL for Tamr
module to setup a google cloud sql instance for Tamr.

# Resources Created
This modules creates the following resources:
* cloud sql instance
* cloud sql role bindings for provided users
* starting database in cloudsql instance


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | >= 3.18.0, <5.0.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.18.0, <5.0.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | name of the cloud sql instance to create | `string` | n/a | yes |
| project\_id | the project to create the sql instance in | `string` | n/a | yes |
| activation\_policy | This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON\_DEMAND | `string` | `"ALWAYS"` | no |
| backup\_enabled | True if backup configuration is enabled. | `bool` | `true` | no |
| backup\_point\_in\_time\_recovery\_enabled | True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation. | `bool` | `true` | no |
| backup\_start\_time | HH:MM format time indicating when backup configuration starts. | `string` | `"06:00"` | no |
| database\_flags | List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags) | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| db\_name | name of the database | `string` | `"doit"` | no |
| deletion\_protection | Set deletion protection on Cloud SQL instance. Unless this field is set to false, a terraform destroy or terraform apply command that deletes the instance will fail. | `bool` | `true` | no |
| disk\_autoresize | Enable disk to autoresize itself | `bool` | `true` | no |
| disk\_size | size of the disk to use | `number` | `100` | no |
| disk\_type | The disk type to use on the instance. should be either PD\_SSD or PD\_STANDARD | `string` | `"PD_SSD"` | no |
| enable\_private\_ip | Whether this instance should use a public or private ip address | `bool` | `false` | no |
| labels | labels to be attached to the resources created | `map(string)` | `{}` | no |
| private\_network\_id | The VPC network from which the Cloud SQL instance is accessible for private IP | `string` | `""` | no |
| region | The region for the instance | `string` | `"us-east1"` | no |
| tier | the machine type to use for the sql instance | `string` | `"db-custom-1-3840"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_name | n/a |
| tamr\_password | n/a |
| uri | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Module usage

This module does NOT configure permissions for cloud-sql viewer or clients. Those permissions will need to be defined
in the Terraform code that consumes this module.

Here are some example stubs to use:

    resource "google_project_iam_binding" "cloud_sql_viewer" {
      project = var.project_id
      role    = "roles/cloudsql.viewer"
      members = []
    }
    
    resource "google_project_iam_binding" "cloud_sql_client" {
      project = var.project_id
      role    = "roles/cloudsql.client"
      members = []
    }

    # Implementers NOTE: this is needed for tamr backups to work
    resource "google_project_iam_binding" "cloud_sql_admin" {
      project = var.project_id
      role    = "roles/cloudsql.admin"
      members = []
    }

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# Development
## Generating Docs
Run `make gen` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test
