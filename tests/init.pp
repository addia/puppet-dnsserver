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
  dns_zone => {
    'example.com' => {
      soa          => 'ns1.example.com',
      soa_email    => 'admin.example.com',
      nameservers  => ['ns1']
      },
    '1.168.192.IN-ADDR.ARPA' => {
      soa          => 'ns1.example.com',
      soa_email    => 'admin.example.com',
      nameservers  => ['ns1']
    }
  },
  dns_a_record => {
    'huey' => {
      zone  => 'example.com',
      data  => ['98.76.54.32'] },
    'duey' => {
      zone  => 'example.com',
      data  => ['12.34.56.78', '12.23.34.45'] },
    'luey' => {
      zone  => 'example.com',
      data  => ['192.168.1.25'],
      ptr   => true}
  },
}
