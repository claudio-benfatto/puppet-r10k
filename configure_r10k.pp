######         ######
##  Configure R10k ##
######         ######

##  This manifest requires the zack/R10k module

class { 'r10k':
  version           => '1.4.0',
  sources           => {
    'puppet' => {
      'remote'  => 'git@github.com:foodity/puppet-base.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
     },

    'hiera' => {
      'remote' => 'git@github.com:foodity/puppet-hieradata.git',
      'basedir'=> "${::settings::confdir}/data",
      'prefix' => false,
     }
    },

  purgedirs         => ["${::settings::confdir}/environments",
                        "${::settings::confdir}/data"],
  manage_modulepath => false,
}

package { 'build-essential':
     ensure => 'installed',
}

package { 'deep_merge':
      ensure   => 'installed',
      provider => 'gem',
}

package { 'hiera-eyaml':
      ensure   => 'installed',
      provider => 'gem',
}

package { 'highline':
      ensure   => 'installed',
      provider => 'gem',
}

Package['build-essential'] ->
Package <| provider == 'gem' |> ->
Class['r10k::install::portage'] ->
Anchor['r10k::ruby_done']



