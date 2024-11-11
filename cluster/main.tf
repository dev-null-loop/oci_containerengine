resource "oci_containerengine_cluster" "this" {
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = var.name
  vcn_id             = var.vcn_id
  cluster_pod_network_options {
    cni_type = var.cni_type
  }
  defined_tags = var.defined_tags
  endpoint_config {
    is_public_ip_enabled = var.endpoint_config.is_public_ip_enabled
    nsg_ids              = var.endpoint_config.nsg_ids
    subnet_id            = var.endpoint_config.subnet_id
  }
  freeform_tags = var.freeform_tags
  dynamic "image_policy_config" {
    for_each = var.image_policy_config[*]
    iterator = ipc
    content {
      is_policy_enabled = ipc.value.is_policy_enabled
      key_details {
	kms_key_id = ipc.value.kms_key_id
      }
    }
  }
  kms_key_id = var.kms_key_id
  dynamic "options" {
    for_each = var.options[*]
    iterator = o
    content {
      add_ons {
	is_kubernetes_dashboard_enabled = o.value.dashboard_enabled
	is_tiller_enabled               = false
      }
      dynamic "kubernetes_network_config" {
	for_each = o.value.kubernetes_network_config[*]
	iterator = knc
	content {
	  pods_cidr     = knc.value.pods_cidr
	  services_cidr = knc.value.var.services_cidr
	}
      }
      dynamic "persistent_volume_config" {
	for_each = o.value.persistent_volume_config[*]
	iterator = pvc
	content {
	  defined_tags  = pvc.value.defined_tags
	  freeform_tags = pvc.value.freeform_tags
	}
      }
      dynamic "service_lb_config" {
	for_each = o.value.service_lb_config[*]
	iterator = slc
	content {
	  defined_tags  = slc.value.defined_tags
	  freeform_tags = slc.value.freeform_tags
	}
      }
      service_lb_subnet_ids = o.value.service_lb_subnet_ids
    }
  }
  type = var.type
}
