######         ######
##  Configure R10k ##
######         ######

##  This manifest requires the zack/R10k module

class { 'r10k':
  version           => '1.3.2',
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
                        "${::settings::confdir}/environments"],
  manage_modulepath => false,
}

