################################################################################

module "phase0" {
  source       = "../"
  dependencies = 0
}

output "phase0_dependencies" {
  value = module.phase0.dependencies
}
################################################################################

resource "null_resource" "one" {
  provisioner "local-exec" {
    command = "echo one; sleep 1"
  }
}

resource "null_resource" "two" {
  provisioner "local-exec" {
    command = "echo two; sleep 1"
  }
}

resource "random_uuid" "uid" {}

module "phase1" {
  source = "../"
  dependencies = [
    module.phase0,
    null_resource.one.id,
    null_resource.two.id,
    random_uuid.uid.result,
  ]
}

output "phase1_dependencies" {
  value = module.phase1.dependencies
}

################################################################################

resource "null_resource" "three" {
  triggers = { dependencies = jsonencode(module.phase1.dependencies) }
  provisioner "local-exec" {
    command = "echo three; sleep 1"
  }
}

module "phase2" {
  source = "../"
  dependencies = {
    one_id   = module.phase1.dependencies.1,
    two_id   = module.phase1.dependencies.2,
    uid_id   = module.phase1.dependencies.3,
    three_id = null_resource.three.id,
  }
}

output "phase2_dependencies" {
  value = module.phase2.dependencies
}

################################################################################
