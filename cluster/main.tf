resource "oci_containerengine_cluster" "this" {
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = var.name
  vcn_id             = var.vcn_id
  type               = var.type
  defined_tags       = var.defined_tags
  freeform_tags      = var.freeform_tags
  kms_key_id         = var.kms_key_id

  cluster_pod_network_options {
    cni_type = var.cni_type
  }

  endpoint_config {
    is_public_ip_enabled = var.is_public_ip_enabled
    nsg_ids              = var.nsg_ids
    subnet_id            = var.subnet_id
  }

  image_policy_config {
    is_policy_enabled = var.is_policy_enabled
    key_details {
      kms_key_id = var.kms_key_id
    }
  }

  options {
    add_ons {
      is_kubernetes_dashboard_enabled = var.dashboard_enabled
      is_tiller_enabled               = false
    }

    kubernetes_network_config {
      pods_cidr     = var.pods_cidr
      services_cidr = var.services_cidr
    }

    persistent_volume_config {
      freeform_tags = var.pvc_tags
    }

    service_lb_config {
      freeform_tags = var.service_lb_tags
    }

    service_lb_subnet_ids = var.service_lb_subnet_ids
  }
}
