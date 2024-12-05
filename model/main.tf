terraform {
  required_providers {
    sdwan = {
      source = "CiscoDevNet/sdwan"
    }
  }
}

module "sdwan" {
  source  = "netascode/nac-sdwan/sdwan"
  version = "0.1.0"

  yaml_directories = ["data/"]

  write_default_values_file = "defaults.yaml"
}
