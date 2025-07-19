output "id" {
  description = "The OCID of the cluster."
  value       = oci_containerengine_cluster.this.id
}

output "service_lb_subnet_ids" {
  description = "The OCIDs of the subnets used for Kubernetes services load balancers."
  value       = oci_containerengine_cluster.this.options[0].service_lb_subnet_ids
}

# options {
#   ip_families           = ["IPv4", ]
#   service_lb_subnet_ids = ["ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaaa255dy2jwu6ufxhfgosrvnelhj46hpnzpv25ceuruyjgtjm2ze4q", ]
#   add_ons {
#     is_kubernetes_dashboard_enabled = false
#     is_tiller_enabled               = false
#   }
#   admission_controller_options {
#     is_pod_security_policy_enabled = false
#   }
#   kubernetes_network_config {
#     pods_cidr     = "10.244.0.0/16"
#     services_cidr = "10.96.0.0/16"
#   }
#   persistent_volume_config {
#     defined_tags  = {}
#     freeform_tags = {}
#   }
#   service_lb_config {
#     defined_tags  = {}
#     freeform_tags = {}
#   }
# }
