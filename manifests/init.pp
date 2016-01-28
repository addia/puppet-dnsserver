# == Class: application
#
# Installs Gradle
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
  $dns_forwarders = [ '8.8.8.8', '8.8.4.4' ],
  ){

  include dns::server

  dns::server::options { '/etc/named/named.conf.options':
    forwarders => $dns_forwarders
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

}
