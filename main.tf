resource "google_project_service" "enable_sql" {
  project = var.project_id
  service = "sqladmin.googleapis.com"

  disable_on_destroy = false
}

resource "google_sql_database_instance" "tamr" {
  name = var.name
  # NOTE: this is pinned as its the version that tamr needs
  database_version = "POSTGRES_12"
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
  depends_on = [google_sql_database_instance.tamr]

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
  count   = length(var.cloud_sql_viewer_members)
  project = var.project_id
  role    = "roles/cloudsql.viewer"
  member  = var.cloud_sql_viewer_members[count.index]
}

resource "google_project_iam_member" "cloud_sql_client" {
  count   = length(var.cloud_sql_client_members)
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = var.cloud_sql_client_members[count.index]
}
