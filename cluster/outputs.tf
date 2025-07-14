output "id" {
  description = "The OCID of the cluster."
  value       = oci_containerengine_cluster.this.id
}

output "service_lb_subnet_ids" {
  description = "The OCIDs of the subnets used for Kubernetes services load balancers."
  value       = [for i in oci_containerengine_cluster.this.options : i.service_lb_subnet_ids]
}
