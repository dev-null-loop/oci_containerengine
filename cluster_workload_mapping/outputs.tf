output "id" {
  description = "The ocid of the workloadMapping."
  value       = oci_containerengine_cluster_workload_mapping.this.id
}

output "state" {
  description = "The state of the workloadMapping."
  value       = oci_containerengine_cluster_workload_mapping.this.state
}

output "time_created" {
  description = "The time the cluster was created."
  value       = oci_containerengine_cluster_workload_mapping.this.time_created
}
