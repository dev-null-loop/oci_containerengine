resource "oci_containerengine_virtual_node_pool" "this" {
  cluster_id     = var.cluster_id
  compartment_id = var.compartment_id
  display_name   = var.display_name
  dynamic "placement_configurations" {
    for_each = var.placement_configurations
    iterator = pc
    content {
      availability_domain = pc.value.availability_domain
      fault_domain        = pc.value.fault_domain
      subnet_id           = pc.value.subnet_id
    }
  }
  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
  dynamic "initial_virtual_node_labels" {
    for_each = var.initial_virtual_node_labels
    iterator = ivnl
    content {
      key   = ivnl.value.key
      value = ivnl.value.value
    }
  }
  nsg_ids = var.nsg_ids
  pod_configuration {
    shape     = var.pod_configuration.shape
    subnet_id = var.pod_configuration.subnet_id
    nsg_ids   = var.pod_configuration.nsg_ids
  }
  size = var.size
  dynamic "taints" {
    for_each = var.taints
    iterator = t
    content {
      effect = t.value.effect
      key    = t.value.key
      value  = t.value.value
    }
  }
  dynamic "virtual_node_tags" {
    for_each = var.virtual_node_tags[*]
    iterator = vnt
    content {
      defined_tags  = vnt.value.defined_tags
      freeform_tags = vnt.value.freeform_tags
    }
  }
}
