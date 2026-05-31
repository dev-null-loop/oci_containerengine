data "oci_containerengine_cluster_kube_config" "this" {
  cluster_id = var.cluster_id
}

locals {
  kubeconfig           = data.oci_containerengine_cluster_kube_config.this.content
  kubeconfig_decoded   = yamldecode(local.kubeconfig)
  first_user           = local.kubeconfig_decoded.users[0]
  first_user_exec      = local.first_user.user.exec
  first_user_exec_args = try(local.first_user_exec.args, [])
  instance_principal_user = merge(local.first_user, {
    user = merge(local.first_user.user, {
      exec = merge(local.first_user_exec, {
        args = concat(local.first_user_exec_args, ["--auth", "instance_principal"])
      })
    })
  })
  kubeconfig_instance_principal = yamlencode(merge(local.kubeconfig_decoded, { users = [local.instance_principal_user] }))
}
