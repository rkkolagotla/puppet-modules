class sudosh
(
$installer = "sudosh.tar.gz",
$dest = "/tmp/sudosh",
)
{

Exec { path => ['/usr/local/sbin','/usr/local/bin','/sbin','/bin','/usr/sbin','/usr/bin','/usr/local/bin','/root/bin'] }

package {'sudo':
ensure => present,
name => sudo,
}

package {'gcc':
ensure => present,
name => gcc,
}

file {"$dest":
ensure => directory,
}

file {"$dest/$installer":
source => "puppet:///modules/sudosh/${installer}",
require => Package['sudo','gcc'],
}

notify {'Notification':
message => "CHECKING FOR SUDOSH AND ELANSUDO for $hostname",
}

exec { 'get_installer':
cwd => "$dest",
command => "tar -zxvf ${installer};cd sudosh;./configure;make;make install",
unless => "test -f /usr/local/bin/sudosh",
require => File["$dest/$installer"],
}

file {"/usr/local/bin/elansudo":
source => "puppet:///modules/sudosh/elansudo",
require => Exec['get_installer'],
}

file {"/etc/sudoers":
source => "puppet:///modules/sudosh/sudoers",
require => Exec['get_installer'],
}

file {"/etc/sudoers.lecture":
source => "puppet:///modules/sudosh/sudoers.lecture",
require => Exec['get_installer'],
}

}
