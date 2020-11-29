#
# This is the role for the puppetserver
#
class role::puppetserver()
{
  contain ::profile::base
  contain ::profile::oci_management
}
