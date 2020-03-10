output "db_ip" {
  value = google_sql_database_instance.database-instance.ip_address
}

output "database_name" {
  value = google_sql_database_instance.database-instance.name
}