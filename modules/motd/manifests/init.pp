class motd ($ensure = present)

{

  notify {"The Value of ENSURE is ${ensure}": }

  file {"/etc/issue":
  ensure => $ensure,
  mode => "0444",
  content => template('motd/issue.erb'),
  owner => "root",
  group => "root",
}

  file {"/etc/motd":
  ensure => $ensure,
  mode => "0444",
  content => template('motd/motd.erb'),
  owner => "root",
  group => "root",
}

  file {"/etc/facter": ensure => directory, recurse => true, }

  file {"/etc/facter/facts.d":
  ensure => link,
  replace => 'no',
  target => "/var/lib/puppet/facts.d",
  require => File["/etc/facter"],
}

}
