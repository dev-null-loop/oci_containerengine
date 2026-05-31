output "kubeconfig" {
  value     = local.kubeconfig
  sensitive = true
}

output "kubeconfig_instance_principal" {
  value     = var.instance_principal_enabled ? local.kubeconfig_instance_principal : null
  sensitive = true
}

output "kubeconfig_filename" {
  value = var.write_files ? local.kubeconfig_filename : null
}

output "kubeconfig_instance_principal_filename" {
  value = var.write_files && var.instance_principal_enabled ? local.kubeconfig_instance_principal_file : null
}
