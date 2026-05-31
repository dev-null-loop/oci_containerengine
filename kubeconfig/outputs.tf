output "kubeconfig" {
  value     = local.kubeconfig
  sensitive = true
}

output "kubeconfig_instance_principal" {
  value     = local.kubeconfig_instance_principal
  sensitive = true
}
