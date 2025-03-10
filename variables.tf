variable "name" {
  type        = string
  description = "name of the cloud sql instance to create"
}

variable "db_name" {
  type        = string
  description = "name of the database"
  default     = "doit"
}

variable "activation_policy" {
  type        = string
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND"
  default     = "ALWAYS"
}

variable "project_id" {
  type        = string
  description = "the project to create the sql instance in"
}

variable "tier" {
  type        = string
  description = "the machine type to use for the sql instance"
  default     = "db-custom-1-3840"
}

variable "disk_size" {
  type        = number
  description = "size of the disk to use"
  default     = 100
}

variable "disk_type" {
  type        = string
  description = "The disk type to use on the instance. should be either PD_SSD or PD_STANDARD"
  default     = "PD_SSD"
}

variable "disk_autoresize" {
  type        = bool
  description = "Enable disk to autoresize itself"
  default     = true
}

variable "labels" {
  type        = map(string)
  description = "labels to be attached to the resources created"
  default     = {}
}

variable "region" {
  type        = string
  description = "The region for the instance"
  default     = "us-east1"
}

variable "backup_enabled" {
  type        = bool
  description = "True if backup configuration is enabled."
  default     = true
}

variable "backup_start_time" {
  type        = string
  description = "HH:MM format time indicating when backup configuration starts."
  default     = "06:00"
}

variable "backup_point_in_time_recovery_enabled" {
  type        = bool
  description = "True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation."
  default     = true
}

variable "enable_private_ip" {
  type        = bool
  description = "Whether this instance should use a public or private ip address"
  default     = false
}

variable "private_network_id" {
  type        = string
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP"
  default     = ""
}

variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags)"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "deletion_protection" {
  type        = bool
  description = "Set deletion protection on Cloud SQL instance. Setting this will protect instances from accidental deletion across all surfaces (API, gcloud, Cloud Console and Terraform)."
  default     = true
}

variable "cloudsql_availability_type" {
  type        = string
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL)."
  default     = "REGIONAL"
}

variable "require_ssl" {
  type        = bool
  description = "Set if SSL is required for the Cloud SQL instance."
  default     = false
}

variable "ssl_mode" {
  type        = string
  description = "Set up the SSL mode. If SSL is required, this value is TRUSTED_CLIENT_CERTIFICATE_REQUIRED."
  default     = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
}

variable "postgres_version" {
  type        = string
  description = "Version of Postgres to install on the CloudSQL instance"
  default     = "POSTGRES_17"
}

