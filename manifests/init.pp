# == Class: application
#
# Installs a dns server
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class dnsserver (
  $dns_zone = undef,
  $dns_a_record = undef,
  $dns_cname_record = undef,
  $dnssec_enable = false,
  $allow_recursion = [ '10.0.0.0/8' ],
  $dns_forwarders = [ '8.8.8.8', '8.8.4.4' ],
  ){

  include dns::server

  dns::server::options { '/etc/named/named.conf.options':
    forwarders => $dns_forwarders,
    allow_recursion => $allow_recursion
  }

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
