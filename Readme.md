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
## NOTE:
if you want  to use the cloud trigger and `cloudbuild.yaml`, you need to set up a  _PROJECT_ID env variable.

## NOTE 2: 
If you  are using cloud build trigger and `cloudbuild.yaml`. 
To allow Cloud Build service account to run Terraform scripts with the goal of managing Google Cloud resources, you need to grant it appropriate access to your project. For simplicity, project editor access is granted in this tutorial. But when the project editor role has a wide-range permission, in production environments you must follow your company's IT security best practices, usually providing least-privileged access.

In Cloud Shell, retrieve the email for your project's Cloud Build service account:

```
CLOUDBUILD_SA="$(gcloud projects describe $PROJECT_ID \
    --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com"
```
Grant the required access to your Cloud Build service account:
```
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:$CLOUDBUILD_SA --role roles/editor 
```