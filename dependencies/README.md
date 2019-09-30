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
# Phase 1 resources
module "one" {}
module "two" {}

# Specify the modules and/or resources that should be created in phase 1
module "phase1" {
  source       = "github.com/iBossOrg/terraform-common/dependencies"
  dependencies = [
    module.one.id,
    module.two.id,
  ]
}

# Phase 2 resouces
resource "my_resource"  "three" {
  depends_on = [
    module.phase1.id,
  ]
}
```
and now you can provision your infrastructure in multiple phases:
```bash
terraform init
terraform apply -target=module.phase1
terraform apply
```
Or you can embed dependencies module in your module:
```hcl
variable "dependencies" {
  type = list(string)
  default = null
}

module "dependencies" {
  source       = "github.com/iBossOrg/terraform-common/dependencies"
  dependencies = var.dependencies == null ? [] : var.dependencies
}

resource "ma_resource" "first" {
  depends_on = [module.dependencies.id]
}
```
and then use it:
```hcl
module "one" {}
module "two" {}

module "my_module" {
  dependencies = [
    module.one.id,
    module.two.id,
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
