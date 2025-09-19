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
  description = "(Optional) (Updatable) The OCIDs of the KMS key that will be used to verify whether the images are signed by an approved source."
  type        = string
  default     = null
}

variable "cni_type" {
  description = "(Required) The CNI used by the node pools of this cluster"
  type        = string
  default     = "FLANNEL_OVERLAY"
  validation {
    condition     = contains(["FLANNEL_OVERLAY", "OCI_VCN_IP_NATIVE"], var.cni_type)
    error_message = "Error: cni_type must be either FLANNEL_OVERLAY or OCI_VCN_IP_NATIVE."
  }
}

variable "endpoint_config" {
  description = "(Required) The network configuration for access to the Cluster control plane."
  type = object({
    is_public_ip_enabled = optional(bool)
    nsg_ids              = optional(list(string))
    subnet_id            = optional(string)
  })
  default = {
    nsg_ids = []
  }
}

variable "image_policy_config" {
  description = "(Optional) (Updatable) The image verification policy for signature validation. Once a policy is created and enabled with one or more kms keys, the policy will ensure all images deployed has been signed with the key(s) attached to the policy. "
  type = object({
    is_policy_enabled = optional(bool)
    kms_key_id        = optional(string)
  })
  default = null
}

variable "options" {
  description = "(Optional) (Updatable) Optional attributes for the cluster."
  type = object({
    dashboard_enabled = optional(bool)
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
      required_claims = optional(object({
	key   = optional(string)
	value = optional(string)
      }))
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
      defined_tags  = optional(map(string))
      freeform_tags = optional(map(string))
    }))
    service_lb_subnet_ids = optional(list(string))
  })
  default = {
    open_id_connect_discovery = {
      is_open_id_connect_discovery_enabled = true
    }
  }
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
