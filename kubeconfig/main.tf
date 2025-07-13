data "oci_containerengine_cluster_kube_config" "this" {
  cluster_id = var.cluster_id
}

resource "local_sensitive_file" "kubeconfig" {
  content         = data.oci_containerengine_cluster_kube_config.this.content
  filename        = "${var.kubeconfig_path}/${var.cluster_name}.yaml"
  file_permission = "600"
}

locals {
  config     = yamldecode(data.oci_containerengine_cluster_kube_config.this.content)
  users      = local.config.users[0]
  exec       = local.config.users[0].user.exec
  args       = local.config.users[0].user.exec.args
  exec_v1    = merge(local.exec, { args = concat(local.args, ["--auth", "instance_principal"]) })
  users_v1   = merge(local.users, { user = { exec = local.exec_v1 } })
  users_v2   = { for k, v in local.config : k => [local.users_v1] if k == "users" }
  kubeconfig = replace(yamlencode(merge(local.config, local.users_v2)), "/\"/", "")
}

resource "local_sensitive_file" "kubeconfig_instance_principal" {
  count           = var.instance_principal_enabled == true ? 1 : 0
  content         = local.kubeconfig
  filename        = "${var.kubeconfig_path}/${var.cluster_name}_instance_principal.yaml"
  file_permission = "600"
}
