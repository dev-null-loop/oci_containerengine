variable "addon_name" {
  description = "(Required) The name of the addon."
  type        = string
}

variable "cluster_id" {
  description = "(Required) The OCID of the cluster."
  type        = string
}

variable "remove_addon_resources_on_delete" {
  description = "(Required) Whether to remove addon resource in deletion."
  type        = bool
  default     = true
}

variable "configurations" {
  description = "(Optional) (Updatable) Addon configuration details"
  type        = map(string)
  default     = {}
}

variable "override_existing" {
  description = "(Optional) Whether or not to override an existing addon installation. Defaults to false. If set to true, any existing addon installation would be overridden as per new installation details."
  type        = bool
  default     = false
}

variable "addon_version" {
  description = "(Optional) (Updatable) The version of addon to be installed."
  type        = number
  default     = null
}
