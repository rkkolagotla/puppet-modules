class mcollective {

define mco() {
package {"$title" :
ensure => installed,
}
}

define shellcmd-agent() {
file {"/usr/libexec/mcollective/mcollective/agent/$title" :
ensure => present,
source => "puppet:///modules/mcollective/mcollective-shellcmd-agent/agent/$title",
mode => 0644,
owner => root,
group => root,
}
}

define files() {
file { "/var/log/$title" :
ensure => present,
}
}

define shellcmd-application() {
file {"/usr/libexec/mcollective/mcollective/application/$title" :
ensure => present,
source => "puppet:///modules/mcollective/mcollective-shellcmd-agent/application/$title",
mode => 0644,
owner => root,
group => root,
}
}

define rpminstall() {
file {"/tmp/$title":
ensure => present,
source => "puppet:///modules/mcollective/$title",
mode => 0644,
}

package {"$title":
provider => gem,
ensure => installed,
source => "/tmp/$title",
require => File["/tmp/$title"],
}

}

$packs = mcopack()

$packages = split($packs," ")

notify{"Mcollective Packages Needs To Be Installed are : $packs": }

$names = [ 'control_f0003', 'control_f0002' ]

files { $names: }

$agent = [ 'shellcmd.ddl', 'shellcmd.rb' ]

$application = [ 'shellcmd.rb' ]

$gem = [ 'open4-1.3.0.gem' ]

mco { $packages: }

rpminstall { $gem: 
notify => Service[mcollective],
}

shellcmd-agent { $agent:
require => File["/etc/mcollective/server.cfg"],
}

notify{'notification':
message => "MAKING CHANGES TO MCOLLECTIVE SERVER.CFG..",
}

file {"/etc/mcollective/server.cfg":
notify => Notify['notification'],
content => template('mcollective/mcollective_server.cfg.erb'),
}

service{"mcollective":
ensure => running,
enable => true,
subscribe => File["/etc/mcollective/server.cfg"],
}
}
