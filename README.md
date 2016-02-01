puppet-dnsserver
=================

## Overview

This will install a dns server to the system where the a records can be managed via puppet

Using puppet manifests:

``` puppet
class { 'dnsserver':
  dns_forwarders => [ '8.8.8.8', '8.8.4.4', '1.1.1.1' ],
  dns_zone => {
    'example.com' => {
      soa          => 'ns1.example.com',
      soa_email    => 'admin.example.com',
      nameservers  => ['ns1.example.com']
      },
    '1.168.192.IN-ADDR.ARPA' => {
      soa          => 'ns1.example.com',
      soa_email    => 'admin.example.com',
      nameservers  => ['ns1.example.com']
    }
  },
  dns_a_record => {
    'ns1' => {
      zone  => 'example.com',
      data  => ['192.168.1.249'] },
    'huey' => {
      zone  => 'example.com',
      data  => ['192.168.1.32'] },
    'duey' => {
      zone  => 'example.com',
      data  => ['12.34.56.78', '12.23.34.45'] },
    'luey' => {
      zone  => 'example.com',
      data  => ['192.168.1.25'],
      ptr   => true }
  },
  dns_cname_record => {
    'hueysbrother' => {
      zone  => 'example.com',
      data  => ['huey.example.com'] },
    'lueysbrother' => {
      zone  => 'example.com',
      data  => ['luey.example.com'] },
  }
} 
```

Using hiera:

``` puppet

---
classes:
  - dnsserver

dnsserver::dns_forwarders:
  - 8.8.8.8
  - 8.8.4.4
  - 1.1.1.1

dnsserver::dns_zone:
  example.com:
    soa: ns1.example.com
    soa_email: admin.example.com
    nameservers: [ns1.example.com]
  1.168.192.IN-ADDR.ARPA:
    soa: ns1.example.com
    soa_email: admin.example.com
    nameservers: [ns1.example.com]

dnsserver::dns_a_record:
  ns1:
    zone: example.com
    data: 192.168.1.249
  huey:
    zone: example.com
    data: 192.168.1.32
  duey:
    zone: 'example.com'
    data:
      - 12.23.34.45
      - 12.34.56.78
  luey:
    zone: example.com
    data: 192.168.1.25
    ptr: true

dnsserver::dns_cname_record:
  hueysbrother:
    zone: example.com
    data: huey.example.com
  lueysbrother:
    zone: example.com
    data: luey.example.com

dnsserver::dns_cname_record:
  huey:
    zone: example.com
    data: huey.example.com
  duey:
    zone: 'example.com'
    data: 12.23.34.45

```

## Executing The Module

This will run the init.pp test in the tests folder.

``` puppet
vagrant up
vagrant ssh
sudo puppet apply /vagrant/tests/init.pp
```

## How to run tests

Run these as a normal user (not root)

```
vagrant up
vagrant ssh
cd /vagrant
sudo yum install -y ruby-devel
sudo yum install -y libffi-devel
sudo yum install -y gcc gcc-c++
sudo yum install -y libxml2-devel
gem install bundler
bundle install
rake validation
```
