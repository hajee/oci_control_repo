#
# This class add's OCI management to the node it is applied on.
#
class profile::oci_management()
{
  echo {"Apply ${name}": withpath => false,}
  require ::oci_profile::configuration
}
