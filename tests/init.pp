# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#



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
