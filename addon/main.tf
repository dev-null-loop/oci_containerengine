resource "oci_containerengine_addon" "this" {
  addon_name                       = var.addon_name
  cluster_id                       = var.cluster_id
  remove_addon_resources_on_delete = var.remove_addon_resources_on_delete
  dynamic "configurations" {
    for_each = var.configurations
    content {
      key   = configuration.key
      value = configuration.value
    }
  }
  override_existing = var.override_existing
  version           = var.addon_version
}
