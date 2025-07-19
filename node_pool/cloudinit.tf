data "cloudinit_config" "this" {
  count         = var.ubuntu_release != null ? 1 : 0
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/cloud-config"
    content = jsonencode(
      {
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
      }
    )
    filename = "50-oke-ubuntu.yml"
  }
}
