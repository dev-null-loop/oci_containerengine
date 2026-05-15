data "oci_identity_availability_domains" "these" {
  compartment_id = var.compartment_id
}

locals {
  ads = data.oci_identity_availability_domains.these.availability_domains
}

resource "oci_containerengine_node_pool" "this" {
  cluster_id     = var.cluster_id
  compartment_id = var.compartment_id
  name           = var.name
  node_shape     = var.node_shape
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
  dynamic "initial_node_labels" {
    for_each = var.initial_node_labels[*]
    iterator = inl
    content {
      key   = inl.value.key
      value = inl.value.value
    }
  }
  kubernetes_version = var.kubernetes_version
  dynamic "node_config_details" {
    for_each = var.node_config_details[*]
    iterator = ncd
    content {
      dynamic "placement_configs" {
        for_each = ncd.value.placement_configs[*]
        iterator = pc
        content {
          availability_domain     = local.ads[pc.value.availability_domain - 1].name
          subnet_id               = var.subnet_ids[pc.value.subnet_name]
          fault_domains           = try([for i in pc.value.fault_domains : format("FAULT-DOMAIN-%s", pc.value.fault_domain)], [])
          capacity_reservation_id = pc.value.capacity_reservation_id
        }
      }
      size                                = ncd.value.size
      is_pv_encryption_in_transit_enabled = ncd.value.is_pv_encryption_in_transit_enabled
      kms_key_id                          = ncd.value.kms_key_id
      dynamic "node_pool_pod_network_option_details" {
        for_each = ncd.value.node_pool_pod_network_option_details[*]
        iterator = i
        content {
          cni_type          = i.value.cni_type
          max_pods_per_node = i.value.max_pods_per_node
          pod_nsg_ids       = i.value.pod_nsg_ids
          pod_subnet_ids = (
            i.value.cni_type == "OCI_VCN_IP_NATIVE" ?
            [for k in i.value.pod_subnet_names : lookup(var.pod_subnet_ids, k)] :
            []
          )
        }
      }
      defined_tags  = ncd.value.defined_tags
      freeform_tags = ncd.value.freeform_tags
      nsg_ids       = ncd.value.nsg_ids
    }
  }
  dynamic "node_eviction_node_pool_settings" {
    for_each = var.node_eviction_node_pool_settings[*]
    iterator = i
    content {
      eviction_grace_duration              = i.value.eviction_grace_duration
      is_force_delete_after_grace_duration = i.value.is_force_delete_after_grace_duration
    }
  }
  node_metadata = merge(
    var.node_metadata,
    length(local.cloud_init_parts) > 0 ? {
      user_data = try(base64encode(data.cloudinit_config.this[0].rendered), null)
    } : {}
  )
  dynamic "node_pool_cycling_details" {
    for_each = var.node_pool_cycling_details[*]
    iterator = npc
    content {
      is_node_cycling_enabled = npc.value.is_node_cycling_enabled
      maximum_surge           = npc.value.maximum_surge
      maximum_unavailable     = npc.value.maximum_unavailable
    }
  }
  dynamic "node_shape_config" {
    for_each = var.node_shape_config[*]
    iterator = nsc
    content {
      memory_in_gbs = nsc.value.memory_in_gbs
      ocpus         = nsc.value.ocpus
    }
  }
  node_source_details {
    boot_volume_size_in_gbs = var.node_source_details.boot_volume_size_in_gbs
    image_id                = var.image_id
    source_type             = "image"
  }
  ssh_public_key = var.ssh_public_key
  timeouts {
    create = "10m"
    delete = "10m"
  }
}
