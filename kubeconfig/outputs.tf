output "kubeconfig" {
  value = data.oci_containerengine_cluster_kube_config.this.content
}

output "kubeconfig_instance_principal" {
  value = local.kubeconfig
}
