resource "google_project_service" "enable_sql" {
  project = var.project_id
  service = "sqladmin.googleapis.com"

  disable_on_destroy = false
}

resource "google_sql_database_instance" "tamr" {
  name    = var.name
  project = var.project_id
  region  = var.region
  # NOTE: this is pinned as its the version that tamr needs
  database_version = "POSTGRES_12"


  settings {
    tier              = var.tier
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    activation_policy = var.activation_policy
    disk_autoresize   = var.disk_autoresize
    user_labels       = var.labels
    availability_type = "REGIONAL"

    dynamic "backup_configuration" {
      for_each = var.backup_enabled ? ["true"] : []
      content {
        enabled                        = true
        start_time                     = var.backup_start_time
        point_in_time_recovery_enabled = var.backup_point_in_time_recovery_enabled
      }
    }

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = lookup(database_flags.value, "name", null)
        value = lookup(database_flags.value, "value", null)
      }
    }

    dynamic "ip_configuration" {
      for_each = var.enable_private_ip ? ["true"] : []
      content {
        ipv4_enabled    = false
        private_network = var.private_network_id
      }
    }
  }
}

resource "google_sql_database" "tamr" {
  depends_on = [google_sql_database_instance.tamr]

  name     = var.db_name
  project  = var.project_id
  instance = google_sql_database_instance.tamr.name
}

# random password for db
resource "random_password" "sql_tamr_user_password" {
  length  = 16
  special = false
}

resource "google_sql_user" "sql_dev_user" {
  depends_on = [google_sql_database_instance.tamr]

  name     = "tamr"
  project  = var.project_id
  instance = google_sql_database_instance.tamr.name
  password = random_password.sql_tamr_user_password.result
}

# TODO: if need more config for the database use postgres
# provider to create the rest of the config
# SEE: https://www.terraform.io/docs/providers/postgresql/index.html


# IAM
resource "google_project_iam_member" "cloud_sql_viewer" {
  for_each = toset(var.cloud_sql_viewer_members)
  project  = var.project_id
  role     = "roles/cloudsql.viewer"
  member   = each.value
}

resource "google_project_iam_member" "cloud_sql_client" {
  for_each = toset(var.cloud_sql_client_members)
  project  = var.project_id
  role     = "roles/cloudsql.client"
  member   = each.value
}

# NOTE: this is needed for backups to work
resource "google_project_iam_member" "cloud_sql_admin" {
  for_each = toset(var.cloud_sql_admin_members)
  project  = var.project_id
  role     = "roles/cloudsql.admin"
  member   = each.value
}

# Enable postgres extensions
resource "postgresql_extension" "pg_trim" {
  name     = "pg_trim"
  database = google_sql_database.tamr.name
}

resource "postgresql_extension" "pg_stat" {
  name     = "pg_stat_statements"
  database = google_sql_database.tamr.name
}