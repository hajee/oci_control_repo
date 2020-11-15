#
# This is the role for the puppetserver
#
class role::puppetserver()
{
  contain ::profile::base
  contain ::oci_profile::config
}
