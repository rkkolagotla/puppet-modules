class root {

user {root:
ensure => present,
home => '/root',
password => '$1$wBgF5YFQ$aIrzcPDkRZ2TrrE0cmvEH/',
uid => '0',
gid => '0',
groups => ['root', 'bin', 'daemon', 'sys', 'adm', 'disk', 'wheel'],
password_max_age => '99999',
password_min_age => '0',
shell            => '/bin/bash',
}

notify {'User ROOT is managed by PUPPET..':}

}
