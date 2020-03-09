# Terraform infrastructure
This repo contain a sample infrastructure to connect a kubernetes cluster and a sql database with a Virtual Private Connection (VPC).

 - `gke` module contains:
    - `google_container_cluster`
    - a "kubernetes" provider
 - `database` module contains:
    - `google_sql_database_instance`
    - `google_sql_database`
    - `google_sql_user`
 - `cloudbuild_trigger`
    - `google_cloudbuild_trigger`
 - `storage`
    - `google_storage_bucket`
 - `pub_sub`
    - `google_pubsub_topic`
    - `google_pubsub_subscription`

### Commands:

Init the workspace:
```
terraform init
```

Create new dev (or prod) workspace:
```
terraform workspace new dev
```

List available workspaces, and check that the correct one is selected:
```
terraform workspace list
```

Select the right workspace if not already so:
```
terraform workspace select dev
```

Do the terraform magic:
```
terraform plan
```
```
terraform apply -auto-approve
```

List and show terraform state file
```
terraform state list
terraform state show
```

If you want to delete:
```
terraform destroy
```