output "dependencies" {
  description = "Dependencies"
  value       = jsondecode(data.null_data_source.dependencies.outputs.dependencies)
}
