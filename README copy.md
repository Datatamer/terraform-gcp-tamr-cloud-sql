# Cloud SQL Module
This module is used to provision a gke cluster, with usage tracking attached.
NOTE: this is only meant for internal usage, as it has some logic that is specific to Tamr's GCP setup.  For example how it parses subnet ranges.  It would be a good starting point for a public module though.
This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "gke_cluster" {
  source = "./shared_files/modules/gcp-tamr-cloud-sql"

  name    = "postgresdb"
  project = "tamr-foo-bar"
}

```

# Resources Created
* A postgres cloud sql instance
* A user and database for tamr to use

# Variables 
## Inputs
Write your Terraform module inputs.
* `name` (required): The name of the cloud sql instance to be created
* `project_id` (required): the project to create the sql instance in
* `tier` (optional): the machine type to use for the sql instance
* `disk_size` (optional): size of the disk to use
* `disk_type` (optional): The disk type to use on the instance. should be either PD_SSD or PD_STANDARD
* `labels` (optional): labels to be attached to the resources created
* `region` (optional): The region for the instance

## Outputs
Write your Terraform module outputs.
* `gke_cluster_name`: name of the gke cluster that was created

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)
This module is inspired by [gruntworks gke module](https://github.com/gruntwork-io/terraform-google-gke)