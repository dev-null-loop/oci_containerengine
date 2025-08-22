- a root call to this module might look like this:
  ``` shell
  module "addons" {
	source     = "git@github.com:dev-null-loop/oci_containerengine//addon"
	for_each   = var.addons
	cluster_id = module.clusters[each.value.cluster_name].id
	addon_name = each.value.addon_name
	configurations = (
	  each.value.addon_name != "NativeIngressController" ?
	  each.value.configurations :
	  merge(each.value.configurations,
		{
	  compartmentId        = var.compartment_ids[each.value.compartment_name],
	  loadBalancerSubnetId = module.sn[each.value.load_balancer_subnet_name].id
		}
	  )
	)
  }
  ```
- I still need to figure out the `AutoScaler` call since that's more complicated (the `nodes` configuration)
