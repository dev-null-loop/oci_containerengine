variable "cluster_id" {
  description = "(Required) The OCID of the cluster."
  type        = string
}

variable "is_public_api_endpoint_decommissioned" {
  description = "(Required)(Updatable) Controls if a public API endpoint decommission or a rollback will happen . true is for raising public api endpoint decommission, false is for rollback public api endpoint decommission"
  type        = bool
}

variable "rollback_deadline_delay" {
  description = "(Optional)(Updatable) Extend rollback deadline for this cluster."
  type        = string
  default     = null
}
