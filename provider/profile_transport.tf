
# TRANSPORT PROFILE

resource "sdwan_transport_feature_profile" "Transport_Profile" {
  name        = "TF_Transport_Profile"
  description = "Terraform transport feature profile 1"
}

# ASSOCIATED PARCELS

resource "sdwan_transport_wan_vpn_profile_parcel" "VPN0_Parcel" {
  name                       = "VPN0"
  description                = "VPN0"
  feature_profile_id         = sdwan_transport_feature_profile.Transport_Profile.id
  vpn                        = 0
  enhance_ecmp_keying        = true
  primary_dns_address_ipv4   = "1.2.3.4"
  secondary_dns_address_ipv4 = "2.3.4.5"
  primary_dns_address_ipv6   = "2001:0:0:1::0"
  secondary_dns_address_ipv6 = "2001:0:0:2::0"
  new_host_mappings = [
    {
      host_name            = "example"
      list_of_ip_addresses = ["1.2.3.4"]
    }
  ]
  ipv4_static_routes = [
    {
      network_address = "1.2.3.4"
      subnet_mask     = "0.0.0.0"
      gateway         = "nextHop"
      next_hops = [
        {
          address                 = "1.2.3.4"
          administrative_distance = 1
        }
      ]
      administrative_distance = 1
    }
  ]
  ipv6_static_routes = [
    {
      prefix = "2002::/16"
      next_hops = [
        {
          address                 = "2001:0:0:1::0"
          administrative_distance = 1
        }
      ]
    }
  ]
  services = [
    {
      service_type = "TE"
    }
  ]
  nat_64_v4_pools = [
    {
      nat64_v4_pool_name        = "example"
      nat64_v4_pool_range_start = "203.0.113.50"
      nat64_v4_pool_range_end   = "203.0.113.100"
      nat64_v4_pool_overload    = false
    }
  ]
}

# MPLS TRANSPORT
resource "sdwan_transport_wan_vpn_interface_ethernet_profile_parcel" "MPLS_Transport" {
  name                                           = "MLS_Transport"
  description                                    = "MPLS Transport Interface"
  feature_profile_id                             = sdwan_transport_feature_profile.Transport_Profile.id
  transport_wan_vpn_profile_parcel_id            = sdwan_transport_wan_vpn_profile_parcel.VPN0_Parcel.id
  shutdown                                       = false
  interface_name                                 = "GigabitEthernet1"
  interface_description                          = "MPLS TRANSPORT"
  ipv4_address                                   = "1.2.3.4"
  ipv4_subnet_mask                               = "0.0.0.0"
  auto_detect_bandwidth                          = true
  tunnel_interface                               = true
  tunnel_interface_carrier                       = "default"
  tunnel_interface_color                         = "mpls"
  tunnel_interface_color_restrict                = true
  tunnel_interface_max_control_connections       = 62
  tunnel_interface_vmanage_connection_preference = 8

  tunnel_interface_encapsulations = [
    {
      encapsulation = "ipsec"
      preference    = 4294967
      weight        = 250
    }
  ]

}

# INTERNET TRANSPORT
resource "sdwan_transport_wan_vpn_interface_ethernet_profile_parcel" "INET_Transport" {
  name                                           = "INET_Transport"
  description                                    = "Internet Transport Interface"
  feature_profile_id                             = sdwan_transport_feature_profile.Transport_Profile.id
  transport_wan_vpn_profile_parcel_id            = sdwan_transport_wan_vpn_profile_parcel.VPN0_Parcel.id
  shutdown                                       = false
  interface_name                                 = "GigabitEthernet2"
  interface_description                          = "INET TRANSPORT"
  ipv4_address                                   = "1.2.3.4"
  ipv4_subnet_mask                               = "0.0.0.0"
  auto_detect_bandwidth                          = true
  tunnel_interface                               = true
  tunnel_interface_carrier                       = "default"
  tunnel_interface_color                         = "mpls"
  tunnel_interface_color_restrict                = true
  tunnel_interface_max_control_connections       = 62
  tunnel_interface_vmanage_connection_preference = 8

  tunnel_interface_encapsulations = [
    {
      encapsulation = "ipsec"
      preference    = 4294967
      weight        = 250
    }
  ]
  nat_ipv4        = true
  nat_type        = "interface"
  nat_udp_timeout = 1
  nat_tcp_timeout = 60
  new_static_nats = [
    {
      source_ip     = "1.2.3.4"
      translated_ip = "2.3.4.5"
      direction     = "inside"
      source_vpn    = 3
    }
  ]
  nat_ipv6 = true
  nat64    = false
  nat66    = true

}
