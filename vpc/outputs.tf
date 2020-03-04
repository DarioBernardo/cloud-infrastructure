output "private-network" {
  value = google_compute_network.private_network
}

output "private-vpc-connection" {
  value = google_service_networking_connection.private_vpc_connection
}

output "subnet-name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Export created CICDR range"
}