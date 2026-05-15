locals {
  cloud_init_parts = concat(
    var.cloud_init,
    var.ubuntu_release != null ? [
      {
        content_type = "text/cloud-config"
        content = jsonencode({
          apt = {
            sources = {
              oke-node = {
                source = format("deb [trusted=yes] https://objectstorage.us-sanjose-1.oraclecloud.com/p/45eOeErEDZqPGiymXZwpeebCNb5lnwzkcQIhtVf6iOF44eet_efdePaF7T8agNYq/n/odx-oke/b/okn-repositories-private/o/prod/ubuntu-%s/kubernetes-%s stable main",
                  var.ubuntu_releases[var.ubuntu_release],
                var.kubernetes_version)
              }
            }
          }
          package_update = true
          packages = [{
            apt = [format("oci-oke-node-all-%s", var.kubernetes_version)]
          }]
          runcmd = [
            "oke bootstrap"
          ]
        })
        filename = "50-oke-ubuntu.yml"
        vars     = {}
      }
    ] : []
  )
}

data "cloudinit_config" "this" {
  count         = length(local.cloud_init_parts) > 0 ? 1 : 0
  gzip          = false
  base64_encode = false
  dynamic "part" {
    for_each = local.cloud_init_parts
    iterator = part
    content {
      content_type = coalesce(part.value.content_type, "text/x-shellscript")
      filename     = part.value.filename != null ? basename(part.value.filename) : null
      content = (
        part.value.filename != null ?
        templatefile("${path.root}/${part.value.filename}", part.value.vars) :
        templatestring(part.value.content, part.value.vars)
      )
      merge_type = "list(append)+dict(no_replace,recurse_list)+str(append)"
    }
  }
}
