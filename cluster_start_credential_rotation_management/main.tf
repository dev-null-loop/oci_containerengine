resource "oci_containerengine_cluster_start_credential_rotation_management" "this" {
  auto_completion_delay_duration = var.auto_completion_delay_duration
  cluster_id                     = var.cluster_id
}
