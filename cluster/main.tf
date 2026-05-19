resource "oci_containerengine_cluster" "this" {
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = var.name
  vcn_id             = var.vcn_id
  dynamic "cluster_pod_network_options" {
    for_each = var.cluster_pod_network_options[*]
    iterator = cpno
    content {
      cni_type = cpno.value.cni_type
    }
  }
  defined_tags = var.defined_tags
  dynamic "endpoint_config" {
    for_each = var.endpoint_config[*]
    iterator = epc
    content {
      is_public_ip_enabled = epc.value.is_public_ip_enabled
      nsg_ids              = epc.value.nsg_ids
      subnet_id            = epc.value.subnet_id
    }
  }
  freeform_tags = var.freeform_tags
  dynamic "image_policy_config" {
    for_each = var.image_policy_config[*]
    iterator = ipc
    content {
      is_policy_enabled = ipc.value.is_policy_enabled
      dynamic "key_details" {
        for_each = ipc.value.key_details
        iterator = kd
        content {
          kms_key_id = kd.value.kms_key_id
        }
      }
    }
  }
  kms_key_id = var.kms_key_id
  dynamic "options" {
    for_each = var.options[*]
    iterator = o
    content {
      dynamic "add_ons" {
        for_each = o.value.add_ons[*]
        iterator = ao
        content {
          is_kubernetes_dashboard_enabled = ao.value.is_kubernetes_dashboard_enabled
          is_tiller_enabled               = ao.value.is_tiller_enabled
        }
      }
      dynamic "admission_controller_options" {
        for_each = o.value.admission_controller_options[*]
        iterator = aco
        content {
          is_pod_security_policy_enabled = aco.value.is_pod_security_policy_enabled
        }
      }
      ip_families = o.value.ip_families
      dynamic "kubernetes_network_config" {
        for_each = o.value.kubernetes_network_config[*]
        iterator = knc
        content {
          pods_cidr     = knc.value.pods_cidr
          services_cidr = knc.value.services_cidr
        }
      }
      dynamic "open_id_connect_token_authentication_config" {
        for_each = o.value.open_id_connect_token_authentication_config[*]
        iterator = open_id
        content {
          is_open_id_connect_auth_enabled = open_id.value.is_open_id_connect_auth_enabled
          ca_certificate                  = open_id.value.ca_certificate
          client_id                       = open_id.value.client_id
          configuration_file              = open_id.value.configuration_file
          groups_claim                    = open_id.value.groups_claim
          groups_prefix                   = open_id.value.groups_prefix
          issuer_url                      = open_id.value.issuer_url
          dynamic "required_claims" {
            for_each = open_id.value.required_claims
            iterator = rc
            content {
              key   = rc.value.key
              value = rc.value.value
            }
          }
          signing_algorithms = open_id.value.signing_algorithms
          username_claim     = open_id.value.username_claim
          username_prefix    = open_id.value.username_prefix
        }
      }
      dynamic "open_id_connect_discovery" {
        for_each = o.value.open_id_connect_discovery[*]
        iterator = oicd
        content {
          is_open_id_connect_discovery_enabled = oicd.value.is_open_id_connect_discovery_enabled
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
          backend_nsg_ids = slc.value.backend_nsg_ids
          defined_tags    = slc.value.defined_tags
          freeform_tags   = slc.value.freeform_tags
        }
      }
      service_lb_subnet_ids = o.value.service_lb_subnet_ids
    }
  }
  type = var.type
}
