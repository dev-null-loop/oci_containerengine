variable "cluster_id" {
  description = "(Required) The OCID of the cluster."
  type        = string
}

variable "mapped_compartment_id" {
  description = "(Required) (Updatable) The OCID of the mapped customer compartment."
  type        = string
}

variable "namespace" {
  description = "(Required) The namespace of the workloadMapping."
  type        = string
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm). Example: `{\\\"Operations.CostCenter\\\": \\\"42\\\"}`"
  type        = map(string)
  default     = null
}

variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm). Example: `{\\\"Department\\\": \\\"Finance\\\"}`"
  type        = map(string)
  default     = {}
}
