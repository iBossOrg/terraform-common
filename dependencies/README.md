# Dependencies module

A helper module that simplifies infrastructure provisioning in multiple
phases (or steps) and workaround to Terraform limitation where there is no
module `depends_on` attribute.

## Prerequisites

On Apple macOS, install [Homebrew](http://brew.sh/) and packages:
```bash
brew install terraform
```
On other platforms, install the appropriate packages.

## Usage

You can bootstrap your infrastructure in phases:
```hcl
### Phase 1 ####################################################################

module "one" {}
module "two" {}

module "phase1" {
  source       = "github.com/iBossOrg/terraform-common/dependencies"
  # Specify the modules and/or resources that should be created in phase 1
  dependencies = {
    one = module.one
    two = module.two
  }
}

### Phase 2 ####################################################################

module "three" {
  id   = module.phase1.dependencies.one.id
  name = module.phase1.dependencies.two.name
}
```
and now you can provision your infrastructure in multiple phases:
```bash
terraform init
terraform apply -target=module.phase1
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
