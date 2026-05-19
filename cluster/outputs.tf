output "id" {
  description = "The OCID of the cluster."
  value       = oci_containerengine_cluster.this.id
}

output "cluster_pod_network_options" {
  description = "Available CNIs and network options for existing and new node pools of the cluster."
  value       = oci_containerengine_cluster.this.cluster_pod_network_options
}

output "compartment_id" {
  description = "The OCID of the compartment in which the cluster exists."
  value       = oci_containerengine_cluster.this.compartment_id
}

output "defined_tags" {
  description = "Defined tags for this resource."
  value       = oci_containerengine_cluster.this.defined_tags
}

output "endpoint_config" {
  description = "The network configuration for access to the Cluster control plane."
  value       = oci_containerengine_cluster.this.endpoint_config
}

output "endpoints" {
  description = "Endpoints served up by the cluster masters."
  value       = oci_containerengine_cluster.this.endpoints
}

output "freeform_tags" {
  description = "Free-form tags for this resource."
  value       = oci_containerengine_cluster.this.freeform_tags
}

output "image_policy_config" {
  description = "The image verification policy for signature validation."
  value       = oci_containerengine_cluster.this.image_policy_config
}

output "kubernetes_network_config" {
  description = "Network configuration for Kubernetes."
  value       = try(oci_containerengine_cluster.this.options[0].kubernetes_network_config, null)
}

output "kms_key_id" {
  description = "The OCID of the KMS key to be used as the master encryption key for Kubernetes secret encryption."
  value       = oci_containerengine_cluster.this.kms_key_id
}

output "lifecycle_details" {
  description = "Details about the state of the cluster masters."
  value       = oci_containerengine_cluster.this.lifecycle_details
}

output "metadata" {
  description = "Metadata about the cluster."
  value       = oci_containerengine_cluster.this.metadata
}

output "service_lb_subnet_ids" {
  description = "The OCIDs of the subnets used for Kubernetes services load balancers."
  value       = try(oci_containerengine_cluster.this.options[0].service_lb_subnet_ids, null)
}

output "name" {
  description = "The name of the cluster."
  value       = oci_containerengine_cluster.this.name
}

output "kubernetes_version" {
  description = "The version of Kubernetes running on the cluster masters."
  value       = oci_containerengine_cluster.this.kubernetes_version
}

output "state" {
  description = "The state of the cluster masters."
  value       = oci_containerengine_cluster.this.state
}

output "available_kubernetes_upgrades" {
  description = "Available Kubernetes versions to which the clusters masters may be upgraded."
  value       = oci_containerengine_cluster.this.available_kubernetes_upgrades
}

output "open_id_connect_discovery_endpoint" {
  description = "The cluster-specific OpenID Connect Discovery endpoint."
  value       = oci_containerengine_cluster.this.open_id_connect_discovery_endpoint
}

output "open_id_connect_discovery_key" {
  description = "The cluster-specific OpenID Connect Discovery Key to derive the DiscoveryEndpoint."
  value       = oci_containerengine_cluster.this.open_id_connect_discovery_key
}

output "options" {
  description = "Optional attributes for the cluster."
  value       = oci_containerengine_cluster.this.options
}

output "type" {
  description = "Type of cluster."
  value       = oci_containerengine_cluster.this.type
}

output "vcn_id" {
  description = "The OCID of the virtual cloud network (VCN) in which the cluster exists."
  value       = oci_containerengine_cluster.this.vcn_id
}
