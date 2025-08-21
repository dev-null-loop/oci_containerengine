resource "oci_containerengine_addon" "this" {
  addon_name                       = var.addon_name
  cluster_id                       = var.cluster_id
  remove_addon_resources_on_delete = var.remove_addon_resources_on_delete
  # dynamic "configurations" {
  #   for_each = var.configurations != null ? var.configurations : []
  #   content {
  #     key   = configurations.value.key
  #     value = configurations.value.value
  #   }
  # }
  # dynamic "configurations" {
  #   for_each = { for k in keys(var.configurations) : k => var.configurations[k] }
  #   content {
  #     key   = configurations.key
  #     value = configurations.value
  #   }
  # }
  dynamic "configurations" {
    for_each = var.configurations[*]
    content {
      key   = each.key
      value = each.value
    }
  }
  override_existing = var.override_existing
  version           = var.addon_version
}

# resource "azurerm_resource_group" "rg" {
#   for_each = tomap({
#     a_group       = "eastus"
#     another_group = "westus2"
#   })
#   name     = each.key
#   location = each.value
# }


# locals {
#   resources_ids = {
#     compartmentId = "ocid1.compartment.oc1..aaaaaaaa7sjjhowkrqmg6hjcsrkzftqgygt272aig2yycgmd5a7paw5unoea"
#   }
#   configurations = {
#     numOfReplicas                                      = 1
#     nodeSelectors                                      = 1
#     tolerations                                        = 1
#     rollingUpdate                                      = 1
#     affinity                                           = 1
#     topologySpreadConstraints                          = 1
#     "oci-native-ingress-controller.ContainerResources" = 1
#     compartmentId                                      = "nodes"
#     loadBalancerSubnetId                               = 1
#     okeHostOverride                                    = 1
#     authType                                           = "instance"
#     authSecretName                                     = 1
#     leaseLockName                                      = 1
#     leaseLockNamespace                                 = 1
#     controllerClass                                    = 1
#     logVerbosity                                       = 1
#     metricsBackend                                     = 1
#     metricsPort                                        = 1
#     namespace                                          = 1
#     useLbCompartmentForCertificates                    = false
#     emitEvents                                         = false
#     certDeletionGracePeriodInDays                      = 0
#   }
# }
