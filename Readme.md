# Terraform infrastructure
This repo contain a sample infrastructure to connect a kubernetes cluster and a sql database with a Virtual Private Connection (VPC).

 - `gke` module contains:
    - `google_container_cluster`
    - a "kubernetes" provider
 - `database` module contains:
    - `google_sql_database_instance`
    - `google_sql_database`
    - `google_sql_user`
 - `vpc` module contains:
    - `google_compute_network`
    - `google_compute_global_address`
    - `google_service_networking_connection`
    - `google_compute_subnetwork`
    - `google_compute_firewall` x2