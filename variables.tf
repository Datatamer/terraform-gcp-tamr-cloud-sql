variable "name" {
  type        = string
  description = "name of the cloud sql instance to create"
}

variable "project_id" {
  type        = string
  description = "the project to create the sql instance in"
}

variable "tier" {
  type        = string
  description = "the machine type to use for the sql instance"
  default     = "db-custom-2-4096"
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
