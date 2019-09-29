# Provisioning Phase module

A helper module that simplifies infrastructure provisioning in multiple
phases (or steps).

## Prerequisites

On Apple macOS, install [Homebrew](http://brew.sh/) and packages:
```bash
brew install terraform
```
On other platforms, install the appropriate packages.

## Usage

Copy and paste into your Terraform configuration, insert the variables, and
run `terraform init`:
```hcl
# Insert modules and/or resources here

# Specify the modules and/or resources that should be created in phase1
module "phase1" {
  source       = "github.com/iBossOrg/terraform-common/provisioning-phase"
  resource_ids = [
    module.one.id,
    module.two.id,
  ]
}

# Specify the modules and/or resources that should be created in phase2
module "phase2" {
  source       = "github.com/iBossOrg/terraform-common/provisioning-phase"
  resource_ids = [
    module.another.id,
  ]
}
```
Now you can provision your infrastructure in multiple phases:
```bash
terraform init
terraform apply -target=module.phase1
terraform apply -target=module.phase2
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
