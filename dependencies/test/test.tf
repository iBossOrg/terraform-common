################################################################################

resource "null_resource" "one" {
  provisioner "local-exec" {
    command = "echo one; sleep 1"
  }
}

################################################################################

resource "null_resource" "two" {
  provisioner "local-exec" {
    command = "echo two; sleep 1"
  }
}

################################################################################

module "phase1" {
  source = "../"
  dependencies = [
    null_resource.one.id,
    null_resource.two.id,
  ]
}

################################################################################

resource "null_resource" "three" {
  depends_on = [module.phase1]
  triggers   = { always = uuid() }
  provisioner "local-exec" {
    command = "echo three; sleep 1"
  }
}

################################################################################

module "phase2" {
  source = "../"
  dependencies = [
    null_resource.three.id,
  ]
}

################################################################################

resource "null_resource" "four" {
  depends_on = [module.phase2]
  triggers = {
    phase2 = module.phase2.id,
  }
  provisioner "local-exec" {
    command = "echo four; sleep 1"
  }
}

################################################################################
