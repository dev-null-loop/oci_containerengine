terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.7.0"
    }
  }
}
