## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

if $::oci_instance['metadata']['disk_info'] { contain profile::os_mounts }
#
# Include the selected role
#
if $::oci_instance['metadata']['role'] { 
  contain $::oci_instance['metadata']['role']
  Class[::profile::os_mounts] -> Class[$::oci_instance['metadata']['role']]
}
#
# And also include the selected additional profiles
#
if $::oci_instance['metadata']['additional_profiles'] { 
  $::oci_instance['metadata']['additional_profiles'].each |$profile| {
    contain $profile
    Class[$::oci_instance['metadata']['role']] -> Class[$profile]
  }
}
