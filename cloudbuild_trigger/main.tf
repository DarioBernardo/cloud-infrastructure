resource "google_cloudbuild_trigger" "bsd-demo-nlp" {
  name = "bsd-demo-nlp-trigger"
  provider = google-beta
//  ignored_files = ["terraform/*"] // which folder the cloud trigger should ignore: changes in this folder will not launch the tigger
  // This is how to specify the remote repo
  github {
    owner = "res-am"
    push {
      branch = "^master"
    }
    name = "bsd-demo-nlp"
  }

  substitutions = {
    _DB_INSTANCE_NAME = var.database-instance-name
    _DB_USERNAME = var.database-username
    _DB_PASSWORD = var.database-password
    _DB_DATABASE_NAME = var.database-schema-name
    _KUBERNETES_CLUSTER = var.cluster-name
    _REGION = var.region
//    _CLOUD_RUN_REGION = var.cloud-run-region
    _BUCKET_NAME = var.bucket-name
    _TOPIC = var.topic-name
    _PUB_SUB_SUBSCRIBER_NAME = var.default-subscription-name
  }

  filename = "cloudbuild.yaml"
}