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
  ){

  include dns::server

  dns::server::options { '/etc/named/named.conf.options':
    forwarders => [ '8.8.8.8', '8.8.4.4' ]
  }

  if $dns_zone {
    create_resources('dns::zone', $dns_zone)
  }

  if $dns_a_record {
    create_resources('dns::record::a', $dns_a_record)
  }

}
