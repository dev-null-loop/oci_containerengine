variable "cluster_id" {
  description = "(Required) The cluster the virtual node pool is associated with. A virtual node pool can only be associated with one cluster."
  type        = string
}

variable "compartment_id" {
  description = "(Required) Compartment of the virtual node pool."
  type        = string
}

variable "display_name" {
  description = "(Required) (Updatable) Display name of the virtual node pool. This is a non-unique value."
  type        = string
}

variable "placement_configurations" {
  description = "(Required) (Updatable) The list of placement configurations which determines where Virtual Nodes will be provisioned across as it relates to the subnet and availability domains. The size attribute determines how many we evenly spread across these placement configurations"
  type = list(object({
    availability_domain = string
    fault_domain        = list(string)
    subnet_id           = string
  }))
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm). Example: `{\"Operations.CostCenter\": \"42\"}`"
  type        = map(string)
  default     = null
}

variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm). Example: `{\"Department\": \"Finance\"}`"
  type        = map(string)
  default     = {}
}

variable "initial_virtual_node_labels" {
  description = "(Optional) (Updatable) Initial labels that will be added to the Kubernetes Virtual Node object when it registers."
  type = list(object({
    key   = optional(string)
    value = optional(string)
  }))
  default = []
}

variable "nsg_ids" {
  description = "(Optional) (Updatable) List of network security group id's applied to the Virtual Node VNIC."
  type        = list(string)
  default     = []
}

variable "pod_configuration" {
  description = "(Required) (Updatable) The pod configuration for pods run on virtual nodes of this virtual node pool."
  type = object({
    shape     = string
    subnet_id = string
    nsg_ids   = optional(list(string), [])
  })
}

variable "size" {
  description = "(Required) (Updatable) The number of Virtual Nodes that should be in the Virtual Node Pool. The placement configurations determine where these virtual nodes are placed."
  type        = number
}

variable "taints" {
  description = "(Optional) (Updatable) A taint is a collection of <key, value, effect>. These taints will be applied to the Virtual Nodes of this Virtual Node Pool for Kubernetes scheduling."
  type = list(object({
    effect = optional(string)
    key    = optional(string)
    value  = optional(string)
  }))
  default = []
}

variable "virtual_node_tags" {
  description = "(Optional) (Updatable) The tags associated to the virtual nodes in this virtual node pool."
  type = object({
    defined_tags  = optional(map(string), null)
    freeform_tags = optional(map(string), {})
  })
  default = null
}
