resource "google_project_service" "enable_sql" {
  project = var.project_id
  service = "sqladmin.googleapis.com"

  disable_on_destroy = false
}

resource "google_sql_database_instance" "tamr" {
  name             = var.name
  project          = var.project_id
  region           = var.region
  database_version = var.postgres_version

  deletion_protection = var.deletion_protection

  lifecycle {
    ignore_changes = [
      settings[0].backup_configuration[0].location,
      settings[0].disk_size, # since we have autoresize enabled, we don't want to change the disk size
    ]

    prevent_destroy = true
  }

  settings {
    tier                        = var.tier
    disk_size                   = var.disk_size
    disk_type                   = var.disk_type
    activation_policy           = var.activation_policy
    disk_autoresize             = var.disk_autoresize
    user_labels                 = var.labels
    availability_type           = var.cloudsql_availability_type
    deletion_protection_enabled = var.deletion_protection


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
        ssl_mode        = var.ssl_mode
      }
    }

    insights_config {
      query_insights_enabled  = true
      query_string_length     = 4500
      record_application_tags = true
      record_client_address   = true
    }

    maintenance_window {
      day          = 5  # Friday
      hour         = 17 # 5pm UTC = 12 pm EST
      update_track = "stable"
    }
  }
}

resource "google_sql_database" "tamr" {
  depends_on = [google_sql_database_instance.tamr]

  name     = var.db_name
  project  = var.project_id
  instance = google_sql_database_instance.tamr.name

  # Prevent deletion of the database inside the instance
  lifecycle {
    prevent_destroy = true
  }
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
  lifecycle {
    prevent_destroy = true
  }
}

# TODO: if need more config for the database use postgres
# provider to create the rest of the config
# SEE: https://www.terraform.io/docs/providers/postgresql/index.html
