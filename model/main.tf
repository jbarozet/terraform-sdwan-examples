terraform {
  required_providers {
    sdwan = {
      source = "CiscoDevNet/sdwan"
    }
  }
}

provider "sdwan" {
  username = local.config.manager.username
  password = local.config.manager.password
  url      = local.config.manager.url
}

module "sdwan" {
  source  = "netascode/nac-sdwan/sdwan"
  version = "1.0.0"

  yaml_directories = ["data/"]

  write_default_values_file = "defaults.yaml"

}
