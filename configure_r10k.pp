######         ######
##  Configure R10k ##
######         ######

##  This manifest requires the zack/R10k module

class { 'r10k':
  version           => '1.5.1',
  provider          => 'gem',
  manage_ruby_dependency => 'ignore',

  sources           => {
    'puppet' => {
      'remote'  => 'git@git.foodity.com:claudio.benfatto/puppet-control.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    },

    'hiera' => {
      'remote' => 'git@github.com:foodity/puppet-hieradata.git',
      'basedir'=> "${::settings::confdir}/data",
      'prefix' => false,
      }
    },

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
Anchor['r10k::ruby_done']
