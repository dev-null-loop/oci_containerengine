variable "auto_completion_delay_duration" {
  description = "(Required) The duration in days(in ISO 8601 notation eg. P5D) after which the old credentials should be retired. Maximum delay duration is 14 days."
  type        = string
}

variable "cluster_id" {
  description = "(Required) The OCID of the cluster."
  type        = string
}
