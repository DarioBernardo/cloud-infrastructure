terraform {
  backend "gcs" {
    bucket = "nlp-infrastructure-state"
    prefix = "test/simple1"
  }
}


// Now it begins!
// Specify the provider that we're using. Include a default region and project.
provider "google-beta" {
  project = var.project-id
  region = var.region #"europe-west2"
}

provider "google" {
  project = var.project-id
  region = var.region
}

module "vpc" {
  source = "./vpc"
  region = var.region
}

module "database" {
  source                     = "./database"
  region                     = var.region
  database-instance-name     = var.database-instance-name
  database-password          = var.database-password
  database-username          = var.database-username
  database-schema-name       = var.database-schema-name
  private-network            = module.vpc.private-network
  private-vpc-connection     = module.vpc.private-vpc-connection
}

module "kubernetes-cluster" {
  source = "./gke"
  region = var.region
  cluster-name = var.cluster-name
  private-network = module.vpc.private-network
  subnet-name           = module.vpc.subnet-name
  private-vpc-connection = module.vpc.private-vpc-connection
  project-id = var.project-id
}