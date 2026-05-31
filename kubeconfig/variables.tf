variable "cluster_id" {
  description = "(Required) The OCID of the cluster."
  type        = string
}

variable "cluster_name" {
  description = "(Required) Cluster name"
  type        = string
}

variable "kubeconfig_path" {
  description = "(Optional) Path to store kubeconfig files to when write_files is enabled."
  type        = string
  default     = "."
}

variable "instance_principal_enabled" {
  description = "(Optional) Whether to generate kubeconfig for an instance principal or not."
  type        = bool
  default     = false
}

variable "write_files" {
  description = "(Optional) Whether to persist kubeconfig files locally or only expose them as outputs."
  type        = bool
  default     = true
}
