resource "oci_containerengine_cluster_workload_mapping" "this" {
  cluster_id            = var.cluster_id
  mapped_compartment_id = var.mapped_compartment_id
  namespace             = var.namespace
  defined_tags          = var.defined_tags
  freeform_tags         = var.freeform_tags
}
