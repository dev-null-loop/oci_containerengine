variable "compartment_id" {
  description = "(Required) Compartment of the virtual node pool."
  type        = string
  nullable    = false
}

variable "cluster_id" {
  description = "Cluster the virtual node pool is associated with. A virtual node pool can only be associated with one cluster"
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "(Required) (Updatable) Display name of the virtual node pool. This is a non-unique value."
  type        = string
  nullable    = false
}

variable "defined_tags" {
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace"
  type        = map(string)
  nullable    = true
  default     = {}
}

variable "freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace"
  type        = map(string)
  nullable    = true
  default     = {}
}

variable "size" {
  description = "The number of Virtual Nodes that should be in the Virtual Node Pool. The placement configurations determine where these virtual nodes are placed"
  type        = number
  nullable    = false
}

variable "initial_virtual_node_labels" {
  description = "Initial labels that will be added to the Kubernetes Virtual Node object when it registers"
  type = list(object({
    key   = string
    value = string
  }))
  nullable = true
  default  = []
}

variable "placement_configurations" {
  description = <<EOT
(Required) (Updatable) The list of placement configurations which determines where Virtual Nodes will be provisioned across as it relates to the subnet and availability domains.
The size attribute determines how many we evenly spread across these placement configurations"
EOT
  type = list(object({
    availability_domain = number
    fault_domain        = number
    subnet_name         = string
  }))
  nullable = false
  default  = []
}

variable "pod_configuration" {
  description = "The pod configuration for pods run on virtual nodes of this virtual node pool"
  type = object({
    shape       = string
    subnet_name = string
    nsg_ids     = optional(list(string))
  })
  nullable = false
}

variable "nsg_ids" {
  description = "List of network security group id's applied to the Virtual Node VNIC"
  type        = list(string)
  nullable    = true
  default     = []
}

variable "taints" {
  description = "(Optional) (Updatable) A taint is a collection of <key, value, effect>. These taints will be applied to the Virtual Nodes of this Virtual Node Pool for Kubernetes scheduling."
  type = list(object({
    effect = optional(string)
    key    = optional(string)
    value  = optional(string)
  }))
  nullable = true
  default  = []
}

variable "virtual_node_tags" {
  description = "The tags associated to the virtual nodes in this virtual node pool"
  type = list(object({
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
  }))
  nullable = true
  default  = []
}

variable "subnet_ids" {
  description = "(Required) (Updatable) The OCIDs of the subnets in which to place the nodes."
  type        = map(string)
}
