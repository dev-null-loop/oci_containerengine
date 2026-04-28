output "id" {
  description = "The addon resource ID."
  value       = oci_containerengine_addon.this.id
}

output "addon_name" {
  description = "The name of the addon."
  value       = oci_containerengine_addon.this.addon_name
}

output "cluster_id" {
  description = "The OCID of the cluster."
  value       = oci_containerengine_addon.this.cluster_id
}

output "state" {
  description = "The state of the addon."
  value       = oci_containerengine_addon.this.state
}

output "current_installed_version" {
  description = "Current installed version of the addon."
  value       = oci_containerengine_addon.this.current_installed_version
}

output "version" {
  description = "Selected addon version."
  value       = oci_containerengine_addon.this.version
}

output "time_created" {
  description = "Creation time of the addon."
  value       = oci_containerengine_addon.this.time_created
}
