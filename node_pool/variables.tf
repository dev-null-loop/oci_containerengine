variable "compartment_id" {
  description = "Compartment OCID"
  type        = string
  nullable    = false
}

variable "cluster_id" {
  description = "(Required) The OCID of the cluster to which this node pool is attached."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Name of node pool"
  type        = string
  nullable    = false
}

variable "node_shape" {
  description = "Nodes shape"
  type        = string
  nullable    = false
}

variable "kubernetes_version" {
  description = "(Optional) (Updatable) The version of Kubernetes to install on the nodes in the node pool."
  type        = string
}

variable "defined_tags" {
  description = "Defined tags"
  type        = map(string)
  default     = null
}

variable "freeform_tags" {
  description = "Free-form tags"
  type        = map(string)
  default     = {}
}

variable "initial_node_labels" {
  description = <<EOT
    `initial_node_labels` - (Optional) (Updatable) A list of key/value pairs to add to nodes after they join the Kubernetes cluster.
       `key` - (Optional) (Updatable) The key of the pair.
       `value` - (Optional) (Updatable) The value of the pair.
  EOT
  type = list(object({
    key   = optional(string)
    value = optional(string)
  }))
  default = []
}

variable "node_config_details" {
  description = "(Optional) (Updatable) The configuration of nodes in the node pool. Exactly one of the subnetIds or nodeConfigDetails properties must be specified."
  type = object({
    placement_configs = list(object({
      availability_domain     = number
      fault_domains           = optional(list(number))
      subnet_name             = string
      capacity_reservation_id = optional(string)
    }))
    size                                = number
    is_pv_encryption_in_transit_enabled = optional(bool)
    kms_key_id                          = optional(string)
    node_pool_pod_network_option_details = optional(object({
      cni_type          = string
      max_pods_per_node = optional(number)
      pod_subnet_names  = optional(list(string))
      pod_nsg_ids       = optional(list(string))
    }))
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    nsg_ids       = optional(list(string))
  })
}

variable "node_eviction_node_pool_settings" {
  description = "(Optional) (Updatable) Node Eviction Details configuration"
  type = object({
    eviction_grace_duration              = optional(string)
    is_force_delete_after_grace_duration = optional(bool)
  })
  default = {
    eviction_grace_duration              = "PT0M"
    is_force_delete_after_grace_duration = true
  }
  validation {
    condition     = can(regex("^(PT)([0-9]?[0-9])(M|H)$", var.node_eviction_node_pool_settings.eviction_grace_duration))
    error_message = "Error: Invalid evictionGraceDuration: Please use ISO 8601 format e.g. PT60M for 60 minutes"
  }
}

variable "node_metadata" {
  description = "(Optional) (Updatable) A list of key/value pairs to add to each underlying Oracle Cloud Infrastructure instance in the node pool on launch."
  type        = map(string)
  default     = {}
}

variable "node_pool_cycling_details" {
  description = "(Optional) (Updatable) Node Pool Cycling Details"
  type = object({
    is_node_cycling_enabled = optional(bool)
    maximum_surge           = optional(number)
    maximum_unavailable     = optional(number)
  })
  default = null
}

variable "node_shape_config" {
  description = "(Optional) (Updatable) Specify the configuration of the shape to launch nodes in the node pool."
  type = object({
    ocpus         = optional(number)
    memory_in_gbs = optional(number)
  })
  default = {
    ocpus         = 1
    memory_in_gbs = 16
  }
}

variable "node_source_details" {
  description = "(Optional) (Updatable) Specify the source to use to launch nodes in the node pool. Currently, image is the only supported source."
  type = object({
    boot_volume_size_in_gbs = optional(number)
    image_name              = string
    source_type             = optional(string)
  })
}

variable "ssh_public_key" {
  description = "(Optional) (Updatable) The SSH public key on each node in the node pool on launch."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "(Optional) (Updatable) The OCIDs of the subnets in which to place nodes for this node pool. When used, quantityPerSubnet can be provided. This property is deprecated, use nodeConfigDetails. Exactly one of the subnetIds or nodeConfigDetails properties must be specified."
  type        = map(string)
}

variable "image_id" {
  description = "(Required) Image OCID to be used for the worker nodes"
  type        = string
}
