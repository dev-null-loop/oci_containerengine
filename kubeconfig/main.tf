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
  kubeconfig_instance_principal      = yamlencode(merge(local.kubeconfig_decoded, { users = [local.instance_principal_user] }))
  kubeconfig_filename                = "${var.kubeconfig_path}/${var.cluster_name}.yaml"
  kubeconfig_instance_principal_file = "${var.kubeconfig_path}/${var.cluster_name}_instance_principal.yaml"
}

resource "local_sensitive_file" "kubeconfig" {
  count           = var.write_files ? 1 : 0
  content         = local.kubeconfig
  filename        = local.kubeconfig_filename
  file_permission = "600"
}

resource "local_sensitive_file" "kubeconfig_instance_principal" {
  count           = var.write_files && var.instance_principal_enabled ? 1 : 0
  content         = local.kubeconfig_instance_principal
  filename        = local.kubeconfig_instance_principal_file
  file_permission = "600"
}
