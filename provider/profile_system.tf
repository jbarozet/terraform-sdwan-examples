
# SYSTEM PROFILE

resource "sdwan_system_feature_profile" "System_Profile" {
  name        = "TF_System_Profile"
  description = "Terraform system feature profile 1"

}

# ASSOCIATED PARCELS

resource "sdwan_system_aaa_profile_parcel" "aaa_parcel" {
  name                 = "TF_AAA_Parcel"
  description          = "Terraform AAA parcel example"
  feature_profile_id   = sdwan_system_feature_profile.System_Profile.id
  authentication_group = true
  accounting_group     = true
  server_auth_order    = ["local"]

  users = [
    {
      name      = "jmb"
      password  = "cisco123"
      privilege = "15"
      public_keys = [
        {
          key_string = "AAAAB3NzaC1yc2"
          key_type   = "ssh-rsa"
        }
      ]
    }
  ]
}

resource "sdwan_system_banner_profile_parcel" "banner_parcel" {
  name               = "TF_Banner_Parcel"
  feature_profile_id = sdwan_system_feature_profile.System_Profile.id
  description        = "Terraform Banner parcel example"
  login              = "Welcome to the SD-WAN network. Authorized access only."
  motd               = "Have a great day!"
}



