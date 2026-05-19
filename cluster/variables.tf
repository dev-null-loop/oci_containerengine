variable "compartment_id" {
  description = "(Required) The OCID of the compartment in which to create the cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "(Required) (Updatable) The version of Kubernetes to install into the cluster masters."
  type        = string
}

variable "name" {
  description = "(Required) (Updatable) The name of the cluster. Avoid entering confidential information."
  type        = string
}

variable "vcn_id" {
  description = "(Required) The OCID of the virtual cloud network (VCN) in which to create the cluster."
  type        = string
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm)."
  type        = map(string)
  default     = null
}

variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm)."
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "(Optional) The OCID of the KMS key to be used as the master encryption key for Kubernetes secret encryption. When used, `kubernetesVersion` must be at least `v1.13.0`."
  type        = string
  default     = null
}

variable "cluster_pod_network_options" {
  description = "(Optional) Available CNIs and network options for existing and new node pools of the cluster."
  type = object({
    cni_type = string
  })
  default = null
}

variable "endpoint_config" {
  description = "(Optional) The network configuration for access to the Cluster control plane."
  type = object({
    is_public_ip_enabled = optional(bool)
    nsg_ids              = optional(list(string), [])
    subnet_id            = string
  })
  default = null
}

variable "image_policy_config" {
  description = "(Optional) (Updatable) The image verification policy for signature validation. Once a policy is created and enabled with one or more kms keys, the policy will ensure all images deployed has been signed with the key(s) attached to the policy. "
  type = object({
    is_policy_enabled = optional(bool)
    key_details = optional(list(object({
      kms_key_id = optional(string)
    })), [])
  })
  default = null
}

variable "options" {
  description = "(Optional) (Updatable) Optional attributes for the cluster."
  type = object({
    add_ons = optional(object({
      is_kubernetes_dashboard_enabled = optional(bool)
      is_tiller_enabled               = optional(bool)
    }))
    admission_controller_options = optional(object({
      is_pod_security_policy_enabled = optional(bool)
    }))
    ip_families = optional(list(string))
    kubernetes_network_config = optional(object({
      pods_cidr     = optional(string)
      services_cidr = optional(string)
    }))
    open_id_connect_token_authentication_config = optional(object({
      ca_certificate                  = optional(string)
      client_id                       = optional(string)
      configuration_file              = optional(string)
      groups_claim                    = optional(string)
      groups_prefix                   = optional(string)
      is_open_id_connect_auth_enabled = bool
      issuer_url                      = optional(string)
      required_claims = optional(list(object({
        key   = optional(string)
        value = optional(string)
      })), [])
      signing_algorithms = optional(list(string))
      username_claim     = optional(string)
      username_prefix    = optional(string)
    }))
    open_id_connect_discovery = optional(object({
      is_open_id_connect_discovery_enabled = optional(bool)
    }))
    persistent_volume_config = optional(object({
      defined_tags  = optional(map(string))
      freeform_tags = optional(map(string))
    }))
    service_lb_config = optional(object({
      backend_nsg_ids = optional(list(string))
      defined_tags    = optional(map(string))
      freeform_tags   = optional(map(string))
    }))
    service_lb_subnet_ids = optional(list(string))
  })
  default = null
}

variable "type" {
  description = "Cluster type: BASIC_CLUSTER or ENHANCED_CLUSTER"
  type        = string
  default     = "ENHANCED_CLUSTER"
  validation {
    condition     = contains(["BASIC_CLUSTER", "ENHANCED_CLUSTER"], var.type)
    error_message = "Cluster TYPE must be BASIC_CLUSTER or ENHANCED_CLUSTER."
  }
}
