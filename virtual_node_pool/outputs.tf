output "id" {
  description = "The OCID of the virtual node pool."
  value       = oci_containerengine_virtual_node_pool.this.id
}

output "cluster_id" {
  description = "The cluster the virtual node pool is associated with. A virtual node pool can only be associated with one cluster."
  value       = oci_containerengine_virtual_node_pool.this.cluster_id
}

output "kubernetes_version" {
  description = "The version of Kubernetes running on the nodes in the node pool."
  value       = oci_containerengine_virtual_node_pool.this.kubernetes_version
}

output "lifecycle_details" {
  description = "Details about the state of the Virtual Node Pool."
  value       = oci_containerengine_virtual_node_pool.this.lifecycle_details
}

output "nsg_ids" {
  description = "List of network security group id's applied to the Virtual Node VNIC."
  value       = oci_containerengine_virtual_node_pool.this.nsg_ids
}

output "placement_configurations" {
  description = "The list of placement configurations which determines where Virtual Nodes will be provisioned across as it relates to the subnet and availability domains. The size attribute determines how many we evenly spread across these placement configurations"
  value       = oci_containerengine_virtual_node_pool.this.placement_configurations
}

output "pod_configuration" {
  description = "The pod configuration for pods run on virtual nodes of this virtual node pool."
  value       = oci_containerengine_virtual_node_pool.this.pod_configuration
}

output "state" {
  description = "The state of the Virtual Node Pool."
  value       = oci_containerengine_virtual_node_pool.this.state
}

output "time_created" {
  description = "The time the virtual node pool was created."
  value       = oci_containerengine_virtual_node_pool.this.time_created
}

output "time_updated" {
  description = "The time the virtual node pool was updated."
  value       = oci_containerengine_virtual_node_pool.this.time_updated
}
