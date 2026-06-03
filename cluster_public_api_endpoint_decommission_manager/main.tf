resource "oci_containerengine_cluster_public_api_endpoint_decommission_manager" "this" {
  cluster_id                            = var.cluster_id
  is_public_api_endpoint_decommissioned = var.is_public_api_endpoint_decommissioned
  rollback_deadline_delay               = var.rollback_deadline_delay
}
