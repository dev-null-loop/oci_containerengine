output "id" {
  description = "The OCID of the cluster."
  value       = oci_containerengine_cluster.this.id
}

output "endpoints" {
  description = "Endpoints served up by the cluster masters."
  value       = oci_containerengine_cluster.this.endpoints
}

output "kubernetes_network_config" {
  description = "Network configuration for Kubernetes."
  value       = oci_containerengine_cluster.this.options[0].kubernetes_network_config
}

output "service_lb_subnet_ids" {
  description = "The OCIDs of the subnets used for Kubernetes services load balancers."
  value       = oci_containerengine_cluster.this.options[0].service_lb_subnet_ids
}
