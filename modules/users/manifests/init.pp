class users {

group {"elanadmin":
ensure => present,
gid => 510,
}

group { 'elanaws':
ensure => 'present',
gid    => '10010',
}

user { "elanadmin":
ensure => present,
comment => "ELANADMIN SHARED ACCOUNT",
uid => 1234,
gid => 510,
password => '$1$34k8YQWG$bdEZOUAKHSlUe18dr5fWu.',
shell => "/bin/bash",
home => "/home/elanadmin",
groups => ["elanadmin","adm","users"],
managehome => true,
}

}
