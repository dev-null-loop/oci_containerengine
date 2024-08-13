variable "compartment_id" {
  description = "(Required) The OCID of the compartment in which to create the cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "(Required) (Updatable) The version of Kubernetes to install into the cluster masters."
  type        = string
}

variable "name" {
  description = "(Required) (Updatable) The name of the cluster. Avoid entering confidential information."
  type        = string
}

variable "vcn_id" {
  description = "(Required) The OCID of the virtual cloud network (VCN) in which to create the cluster."
  type        = string
}

variable "type" {
  description = "Cluster type: BASIC_CLUSTER or ENHANCED_CLUSTER"
  type        = string
  default     = "ENHANCED_CLUSTER"
  validation {
    condition     = contains(["BASIC_CLUSTER", "ENHANCED_CLUSTER"], var.type)
    error_message = "Cluster TYPE must be BASIC_CLUSTER or ENHANCED_CLUSTER."
  }
}

variable "defined_tags" {
  description = "Defined tags"
  type        = map(string)
  default     = null
}

variable "freeform_tags" {
  description = "Free-form tags"
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "(Optional) (Updatable) The OCIDs of the KMS key that will be used to verify whether the images are signed by an approved source."
  type        = string
  default     = null
}

variable "cni_type" {
  description = "(Required) The CNI used by the node pools of this cluster"
  type        = string
  default     = "FLANNEL_OVERLAY"
  validation {
    condition     = contains(["FLANNEL_OVERLAY", "OCI_VCN_IP_NATIVE"], var.cni_type)
    error_message = "Error: cni_type must be either FLANNEL_OVERLAY or OCI_VCN_IP_NATIVE."
  }
}

variable "is_public_ip_enabled" {
  description = "(Optional) Whether the cluster should be assigned a public IP address. Defaults to false. If set to true on a private subnet, the cluster provisioning will fail."
  type        = bool
  default     = false
}

variable "nsg_ids" {
  description = "(Optional) A list of the OCIDs of the network security groups (NSGs) to apply to the cluster endpoint. For more information about NSGs, see [NetworkSecurityGroup](https://docs.cloud.oracle.com/iaas/api/#/en/iaas/20160918/NetworkSecurityGroup/)."
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "(Optional) The OCID of the regional subnet in which to place the Cluster endpoint."
  type        = string
}

variable "dashboard_enabled" {
  description = "(Optional) Whether or not to enable the Kubernetes Dashboard add-on."
  type        = bool
  default     = false
}

variable "pods_cidr" {
  description = "(Optional) The CIDR block for Kubernetes pods. Optional, defaults to 10.244.0.0/16."
  type        = string
  default     = "10.244.0.0/16"
}

variable "services_cidr" {
  description = "(Optional) The CIDR block for Kubernetes services. Optional, defaults to 10.96.0.0/16."
  type        = string
  default     = "10.96.0.0/16"
}

variable "pvc_tags" {
  description = "Tags used for PVC"
  type        = map(string)
  default     = {}
}

variable "service_lb_tags" {
  description = "Tags used for Service LB"
  type        = map(string)
  default     = {}
}

variable "service_lb_subnet_ids" {
  description = "OCIDs of the subnets used for Kubernetes services load balancers"
  type        = list(any)
  default     = []
}

variable "is_policy_enabled" {
  description = "(Optional) (Updatable) Whether or not to enable the Pod Security Policy admission controller."
  type        = bool
  default     = false
}
