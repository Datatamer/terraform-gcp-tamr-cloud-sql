output "tamr_password" {
  value = random_password.sql_tamr_user_password.result
}

output "instance_name" {
  value = google_sql_database_instance.tamr.name
}

output "uri" {
  value = google_sql_database_instance.tamr.self_link
}
