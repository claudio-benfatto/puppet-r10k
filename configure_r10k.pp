######         ######
##  Configure R10k ##
######         ######

##  This manifest requires the zack/R10k module

class { 'r10k':
  version           => '1.4.0',
  sources           => {
    'puppet' => {
      'remote'  => 'git@git.foodity.com:claudio.benfatto/puppet-control.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
     },

    'hiera' => {
      'remote' => 'git@git.foodity.com:claudio.benfatto/puppet-hieradata.git',
      'basedir'=> "${::settings::confdir}/data",
      'prefix' => false,
     }
    },

  purgedirs         => ["${::settings::confdir}/environments",
                        "${::settings::confdir}/data"],
  manage_modulepath => false,
}

package { 'deep_merge':
      ensure       => 'installed',
      provider => 'gem',
}

package { 'hiera-eyaml':
      ensure   => 'installed',
      provider => 'gem',
}

package { 'hiera-eyaml-gpg':
      ensure   => 'installed',
      provider => 'gem',
}

package { 'highline':
      ensure   => 'installed',
      provider => 'gem',
}

Package <| provider == 'gem' |> -> Anchor['r10k::ruby_done']
