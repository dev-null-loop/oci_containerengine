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
      compute_cluster_id = ncd.value.compute_cluster_id
      dynamic "placement_configs" {
        for_each = ncd.value.placement_configs[*]
        iterator = pc
        content {
          availability_domain     = pc.value.availability_domain
          subnet_id               = pc.value.subnet_id
          fault_domains           = pc.value.fault_domains
          capacity_reservation_id = pc.value.capacity_reservation_id
          host_group_id           = pc.value.host_group_id
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
          pod_subnet_ids    = i.value.pod_subnet_ids
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
  dynamic "secondary_vnics" {
    for_each = var.secondary_vnics
    iterator = sv
    content {
      display_name = sv.value.display_name
      nic_index    = sv.value.nic_index
      dynamic "create_vnic_details" {
        for_each = [sv.value.create_vnic_details]
        iterator = cvd
        content {
          application_resources  = cvd.value.application_resources
          assign_ipv6ip          = cvd.value.assign_ipv6ip
          assign_public_ip       = cvd.value.assign_public_ip
          defined_tags           = cvd.value.defined_tags
          display_name           = cvd.value.display_name
          freeform_tags          = cvd.value.freeform_tags
          ip_count               = cvd.value.ip_count
          nsg_ids                = cvd.value.nsg_ids
          security_attributes    = cvd.value.security_attributes
          skip_source_dest_check = cvd.value.skip_source_dest_check
          subnet_id              = cvd.value.subnet_id
          dynamic "ipv6address_ipv6subnet_cidr_pair_details" {
            for_each = cvd.value.ipv6address_ipv6subnet_cidr_pair_details
            iterator = ipv6
            content {
              ipv6address     = ipv6.value.ipv6address
              ipv6subnet_cidr = ipv6.value.ipv6subnet_cidr
            }
          }
        }
      }
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
