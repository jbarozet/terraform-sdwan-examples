terraform {
  required_providers {
    sdwan = {
      source = "CiscoDevNet/sdwan"
    }
  }
}

provider "sdwan" {
  username = "jmb"
  password = "sdwanlab123"
  url      = "https://10.54.60.30"
}



