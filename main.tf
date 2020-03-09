terraform {
  backend "gcs" {
    bucket = "nlp-infrastructure-state"
    prefix = "example/_ENV_"
  }
}


// Now it begins!
// Specify the provider that we're using. Include a default region and project.
//provider "google-beta" {
//  project = var.project-id
//  region = var.region #"europe-west2"
//}

provider "google" {
  project = var.project-id
  region = var.region
}

module "database" {
  source                     = "./database"
  region                     = var.region
  database-instance-name     = var.database-instance-name
  database-password          = var.database-password
  database-username          = var.database-username
  database-schema-name       = var.database-schema-name
}

//module "kubernetes-cluster" {
//  source = "./gke"
//  region = var.region
//  cluster-name = var.cluster-name
//  project-id = var.project-id
//  credentials-email = var.credentials-email
//  }
//
//module "storage" {
//  source = "./storage"
//  region = var.region
//  project-id = var.project-id
//  bucket-name = var.bucket-name
//}
//
//module "pub-sub" {
//  source = "./pub_sub"
//  region = var.region
//  project-id = var.project-id
//  default-subscription-name = var.default-subscription-name
//  topic-name = var.topic-name
//}
//
//module "cloudbuild-trigger" {
//  source = "./cloudbuild_trigger"
//  region = var.region
//  cluster-name = var.cluster-name
//  project-id = var.project-id
//  database-instance-name = module.database.database_name
//  database-password = var.database-password
//  database-schema-name = var.database-schema-name
//  database-username = var.database-username
//  bucket-name = var.bucket-name
//  default-subscription-name = module.pub-sub.pubsub_subscription_name
//  topic-name = module.pub-sub.topic_name
//}
//
//
