output "id" {
  value = oci_containerengine_node_pool.this.id
}

output "nodes" {
  description = "The nodes in the node pool"
  value       = oci_containerengine_node_pool.this.nodes
}
