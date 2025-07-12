variable "cluster_id" {
  description = "(Required) The OCID of the cluster."
  type        = string
}

variable "cluster_name" {
  description = "(Required) Cluster name"
  type        = string
}

variable "oci_profile" {
  description = "(Optional) OCI config profile"
  type        = string
  default     = "DEFAULT"
}

variable "helm_config_dir" {
  description = "(Optional) Path where OKE config files will be saved"
  type        = string
  default     = "."
}

variable "providers_enabled" {
  description = "(Optional) Wheter to generate helm/kubernetes provider configuration file or not"
  type        = bool
  default     = false
}


variable "instance_principal_enabled" {
  description = "(Optional) Whether to generate kubeconfig for an instance principal or not."
  type        = bool
  default     = false
}
