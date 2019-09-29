resource "null_resource" "phase" {
  triggers = {
    resource_ids = join(",", var.resource_ids)
  }
}
