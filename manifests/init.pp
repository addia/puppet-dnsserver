# == Class: dnsserver
# ===========================
#
#
# Description of the Class:
#
#   Install and configure a non-public locally serving and caching dns server
#
#
# Document all Parameters:
#
#   Explanation of what this parameter affects and what it defaults to.
#   dns_zone                           = a zone file
#   dns_a_record                       = a dns A record
#   dns_cname_record                   = a dns cname record
#   dnssec_enable                      = bolean true or false
#   listen_on_ipv6                     = bolean true or false
#   options                            = options for the sysconf file
#   allow_recursion                    = enable with listen IPs
#   dns_forwarders                     = enable with IP addresses of remote dns provisers
#
# ===========================
#
#
# == Authors
# ----------
#
# Author: John Stern  and  Addi <addi.abel@gmail.com>
#
#
# == Copyright
# ------------
#
# Copyright:  ©  2016  LR
#
#
class dnsserver (
  $dns_zone = undef,
  $dns_a_record = undef,
  $dns_cname_record = undef,
  $dnssec_enable = "",
  $listen_on_ipv6 = "",
  $def_options = '-4',
  $allow_recursion = [ '127.0.0.1', '10.0.0.0/8' ],
  $dns_forwarders = [ '8.8.8.8', '8.8.4.4' ],
  ){

  include dns::server

  dns::server::options { '/etc/named/named.conf.options':
    forwarders      => $dns_forwarders,
    allow_recursion => $allow_recursion,
    dnssec_enable   => $dnssec_enable,
    listen_on_ipv6  => $listen_on_ipv6,
  }

# dns::server::default { '/etc/sysconfig/named':
#   options         => $options
# }

  if $dns_zone {
    create_resources('dns::zone', $dns_zone)
  }

  if $dns_a_record {
    create_resources('dns::record::a', $dns_a_record)
  }

  if $dns_cname_record {
    create_resources('dns::record::cname', $dns_cname_record)
  }

  # Load SELinuux policy for named
  selinux::module { 'dns':
    ensure => 'present',
    source => 'puppet:///modules/dnsserver/dns.te'
  }

}
