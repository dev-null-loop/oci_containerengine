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
- to list all annotations for all `OKE` operators execute the following stack:

``` shell
data "oci_containerengine_addon_options" "these" {
  for_each           = toset(local.addons)
  kubernetes_version = "v1.33.1"
  addon_name         = each.key
}

output "addons_annotations" {
  value = { for k, v in data.oci_containerengine_addon_options.these :
	k => {
	  for i in v.addon_options[0].versions[0].configurations : i.key => i.value
	}
  }
}
```

- or faster: `oci ce addon-option list --kubernetes-version v1.33.1 *| jq -r '.data[]|select(."name" == "Istio")|.versions[0].configurations[] | {(.key): .value}'`
