data "oci_containerengine_cluster_kube_config" "this" {
  cluster_id = var.cluster_id
}

resource "local_sensitive_file" "kubeconfig" {
  content         = data.oci_containerengine_cluster_kube_config.this.content
  filename        = "${var.kubeconfig_path}/${var.cluster_name}.yaml"
  file_permission = "600"
}

locals {
  config         = yamldecode(data.oci_containerengine_cluster_kube_config.this.content)
  users          = local.config.users[0]
  exec           = local.config.users[0].user.exec
  args           = local.config.users[0].user.exec.args
  exec_v1        = merge(local.exec, { args = concat(local.args, ["--auth", "instance_principal"]) })
  users_v1       = merge(local.users, { user = { exec = local.exec_v1 } })
  users_v2       = { for k, v in local.config : k => [local.users_v1] if k == "users" }
  cluster_config = replace(yamlencode(merge(local.config, local.users_v2)), "/\"/", "")
}

resource "local_sensitive_file" "kubeconfig_instance_principal" {
  count           = var.instance_principal_enabled == true ? 1 : 0
  content         = local.cluster_config
  filename        = "${var.helm_config_dir}/${var.cluster_name}_instance_principal.yaml"
  file_permission = "600"
}

locals {
  kube_decode = yamldecode(data.oci_containerengine_cluster_kube_config.this.content)
  kube_config = {
    "host" : local.kube_decode.clusters[0].cluster.server,
    "cluster_ca_certificate" : local.kube_decode.clusters[0].cluster.certificate-authority-data,
    "api_version" : local.kube_decode.users[0].user.exec.apiVersion,
    "cluster_id" : local.kube_decode.users[0].user.exec.args[4],
    "cluster_region" : local.kube_decode.users[0].user.exec.args[6]
  }
}

resource "local_sensitive_file" "provider" {
  count = var.providers_enabled == true ? 1 : 0
  content = templatefile("${path.module}/providers.tftpl",
    {
      host           = local.kube_config.host,
      cert           = local.kube_config.cluster_ca_certificate,
      api_version    = local.kube_config.api_version,
      cluster_id     = local.kube_config.cluster_id
      profile        = var.oci_profile
      cluster_region = local.kube_config.cluster_region
  })
  filename        = "${var.helm_config_dir}/helm_provider_${var.cluster_name}.tf"
  file_permission = "600"
}
