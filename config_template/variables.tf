variable "cluster_id" {
  description = "OCID of the cluster to which this node pool is attached"
  type        = string
}

variable "cluster_name" {
  description = "cluster name key"
  type        = string
}

variable "oci_profile" {
  description = "OCI config profile"
  default     = "DEFAULT"
  type        = string
}

variable "helm_config_dir" {
  description = "Path where OKE config files will be saved"
  default     = "./"
  type        = string
}
