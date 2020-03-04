resource "google_container_cluster" "cluster" {
  name = var.cluster-name
  location = var.region
  initial_node_count = 1
  project = var.project-id
  network = var.private-network.self_link # google_compute_network.private_network.self_link
  subnetwork = var.subnet-name
  depends_on = [var.private-vpc-connection] # [google_service_networking_connection.private_vpc_connection]
}

provider "kubernetes" {
  host     = google_container_cluster.cluster.endpoint
  username = google_container_cluster.cluster.master_auth.0.username
  password = google_container_cluster.cluster.master_auth.0.password
  client_certificate     = base64decode(google_container_cluster.cluster.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)
  load_config_file = "false"
//  alias = "default"
}