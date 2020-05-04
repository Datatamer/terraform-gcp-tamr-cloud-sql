resource "google_sql_database_instance" "tamr" {
  name             = var.name
  # NOTE: this is pinned as its the version that tamr needs
  database_version = "POSTGRES_9_6"
  project          = var.project_id

  settings {
    tier              = var.tier
    availability_type = "REGIONAL"
    disk_size         = var.disk_size
    disk_type         = var.disk_type

    user_labels = var.labels
  }

  region = var.region
}

resource "google_sql_database" "tamr" {
  name     = "doit"
  project  = var.project_id
  instance = google_sql_database_instance.tamr.name
}

# random password for db
resource "random_password" "sql_tamr_user_password" {
  length  = 16
  special = false
}

resource "google_sql_user" "sql_dev_user" {
  name     = "tamr"
  project  = var.project_id
  instance = google_sql_database_instance.tamr.name
  password = random_password.sql_tamr_user_password.result
}

# TODO: if need more config for the database use postgres
# provider to create the rest of the config
# SEE: https://www.terraform.io/docs/providers/postgresql/index.html
