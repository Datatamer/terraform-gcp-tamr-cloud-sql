provider "postgresql" {
  scheme   = "gcppostgres"
  host     = google_sql_database_instance.tamr.connection_name
  username = google_sql_user.sql_dev_user.name
  password = google_sql_user.sql_dev_user.password
}
