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


variable "cloud_sql_viewer_members" {
  type        = list(string)
  description = "The list of members to bind to sql viewer role"
  default     = []
}

variable "cloud_sql_client_members" {
  type        = list(string)
  description = "The list of members to bind to sql client role"
  default     = []
}

variable "cloud_sql_admin_members" {
  type        = list(string)
  description = "The list of members to bind to sql admin role"
  default     = []
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

variable "query_string_length" {
  type        = number
  description = "Maximum query length stored in bytes. Between 256 and 4500. Default value is 1024."
  default     = 4500
}

variable "record_application_tags" {
  description = "Query Insights will record application tags from query when enabled."
  type        = bool
  default     = true
}

variable "record_client_address" {
  description = "Query Insights will record client address when enabled."
  type        = bool
  default     = true
}

variable "mw_day" {
  description = "Day of week (1-7), starting on Monday to declare one-hour MW when an instance can automatically restart to apply updates"
  type        = number
  default     = 2
}

variable "mw_hour" {
  description = "Hour of day (0-23) in UTC to declare one-hour MW when an instance can automatically restart to apply updates. Ignored if MW day is not set. "
  type        = number
  default     = 10
}

variable "mw_update_track" {
  description = "Receive maintenance updates earlier (canary) or later (stable)"
  type        = string
  default     = "stable"
}
