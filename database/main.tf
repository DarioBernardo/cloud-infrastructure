provider "random" {}

resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.database-instance-name}-"
}


resource "google_sql_database_instance" "database-instance" {
  name              = random_id.id.hex #var.database-instance-name
  database_version = "POSTGRES_11"
  region           = var.region
  depends_on = [var.private-vpc-connection] #[google_service_networking_connection.private_vpc_connection]

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See https://cloud.google.com/sql/pricing#pg-pricing for al types.
    # NOTE: Only custom machine instance type and shared-core instance type allowed for PostgreSQL database.
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.private-network.self_link
      authorized_networks {
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "sql-database" {
  name = var.database-schema-name
  instance = google_sql_database_instance.database-instance.name
}

resource "google_sql_user" "users" {
  name     = var.database-username
  instance = google_sql_database_instance.database-instance.name
  password = var.database-password
}