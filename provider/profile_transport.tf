
# TRANSPORT PROFILE

resource "sdwan_transport_feature_profile" "Transport_Profile" {
  name        = "TF_Transport_Profile"
  description = "Terraform transport feature profile 1"
}

# VPN0

resource "sdwan_transport_wan_vpn_profile_parcel" "VPN0_Parcel" {
  name                       = "VPN0"
  description                = "VPN0"
  feature_profile_id         = sdwan_transport_feature_profile.Transport_Profile.id
  vpn                        = 0
  enhance_ecmp_keying        = true
  primary_dns_address_ipv4   = "172.16.1.254"
  secondary_dns_address_ipv4 = "1.1.1.1"
  # primary_dns_address_ipv6   = "2001:0:0:1::0"
  # secondary_dns_address_ipv6 = "2001:0:0:2::0"
  new_host_mappings = [
    {
      host_name            = "gateway_inet"
      list_of_ip_addresses = ["172.16.1.254"]
    },
    {
      host_name            = "gateway_mpls"
      list_of_ip_addresses = ["172.16.2.254"]
    }
  ]
  ipv4_static_routes = [
    {
      network_address = "0.0.0.0"
      subnet_mask     = "0.0.0.0"
      gateway         = "nextHop"
      next_hops = [
        {
          address                 = "172.16.1.254"
          administrative_distance = 1
        },
        {
          address                 = "172.16.2.254"
          administrative_distance = 1
        }
      ]
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
}

# INTERNET TRANSPORT
resource "sdwan_transport_wan_vpn_interface_ethernet_profile_parcel" "INET_Transport" {
  name                                           = "INET_Transport"
  description                                    = "Internet Transport Interface"
  feature_profile_id                             = sdwan_transport_feature_profile.Transport_Profile.id
  transport_wan_vpn_profile_parcel_id            = sdwan_transport_wan_vpn_profile_parcel.VPN0_Parcel.id
  shutdown                                       = false
  interface_name                                 = "GigabitEthernet1"
  interface_description                          = "INET TRANSPORT"
  ipv4_address                                   = "172.16.1.1"
  ipv4_subnet_mask                               = "255.255.255.0"
  auto_detect_bandwidth                          = true
  tunnel_interface                               = true
  tunnel_interface_carrier                       = "default"
  tunnel_interface_color                         = "biz-internet"
  tunnel_interface_color_restrict                = true
  tunnel_interface_max_control_connections       = 4
  tunnel_interface_vmanage_connection_preference = 8

  tunnel_interface_encapsulations = [
    {
      encapsulation = "ipsec"
      preference    = 100
      weight        = 250
    }
  ]
  nat_ipv4        = true
  nat_type        = "interface"
  nat_udp_timeout = 1
  nat_tcp_timeout = 60
  nat_ipv6        = true
  nat64           = false
  nat66           = true

}

# MPLS TRANSPORT
resource "sdwan_transport_wan_vpn_interface_ethernet_profile_parcel" "MPLS_Transport" {
  name                                           = "MLS_Transport"
  description                                    = "MPLS Transport Interface"
  feature_profile_id                             = sdwan_transport_feature_profile.Transport_Profile.id
  transport_wan_vpn_profile_parcel_id            = sdwan_transport_wan_vpn_profile_parcel.VPN0_Parcel.id
  shutdown                                       = false
  interface_name                                 = "GigabitEthernet2"
  interface_description                          = "MPLS TRANSPORT"
  ipv4_address                                   = "172.16.2.1"
  ipv4_subnet_mask                               = "255.255.255.0"
  auto_detect_bandwidth                          = true
  tunnel_interface                               = true
  tunnel_interface_carrier                       = "default"
  tunnel_interface_color                         = "mpls"
  tunnel_interface_color_restrict                = true
  tunnel_interface_max_control_connections       = 4
  tunnel_interface_vmanage_connection_preference = 8

  tunnel_interface_encapsulations = [
    {
      encapsulation = "ipsec"
      preference    = 200
      weight        = 250
    }
  ]

}
