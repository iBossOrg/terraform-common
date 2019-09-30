resource "null_resource" "dependencies" {
  triggers = {
    dependencies = join(",", var.dependencies)
  }
}
