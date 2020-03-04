output "db_ip" {
  value = google_sql_database_instance.database-instance.ip_address
}

output "db_private_ip" {
  value = google_sql_database_instance.database-instance.private_ip_address
}