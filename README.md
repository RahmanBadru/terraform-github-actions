# terraform-github-actions

This is a test repo to see how to use github actions to run terraform commands. The goal is to have a workflow that will run terraform plan and apply when changes are made to the repo.

## List of things to do

- [x] Authenticate to the cloud provider with OIDC
- [x] Create a terraform init workflow
- [x] Create a terraform validate workflow on push
- [x] Create a terraform plan workflow
- [x] Create a terraform apply workflow on manual trigger
- [x] Create a terraform destroy workflow on manual trigger
