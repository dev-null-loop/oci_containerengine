variable "cluster_id" {
  description = "OCID of the OKE cluster"
  type        = string
}

variable "cluster_name" {
  description = "cluster name key"
  type        = string
}

variable "oci_profile" {
  description = "OCI config profile"
  type        = string
  default     = "DEFAULT"
}

variable "helm_config_dir" {
  description = "Path where OKE config files will be saved"
  type        = string
  default     = "."
}

variable "providers_enabled" {
  description = "Create helm/kubernetes provider configuration file or not"
  type        = bool
  default     = false
}
