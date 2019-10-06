data "null_data_source" "dependencies" {
  inputs = {
    dependencies = jsonencode(var.dependencies)
  }
}
