output "tamr_password" {
  value = random_password.sql_tamr_user_password.result
}
