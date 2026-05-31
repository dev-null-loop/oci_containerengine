terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
    oci = {
      source  = "oracle/oci"
      version = ">= 7.0.0"
    }
  }
  required_version = ">= 1.5.7"
}
