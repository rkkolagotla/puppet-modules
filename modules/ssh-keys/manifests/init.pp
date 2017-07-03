class ssh-keys{

ssh_authorized_key {'EDALLINP01.ELAN.ELANTECS.COM':
ensure => 'present',
user => 'root',
type => 'ssh-rsa',
key => hiera('ssh-keys::ssh-pubkey-edallinp01'),
}

ssh_authorized_key {'RMOTURI-LOGIN':
ensure => 'present',
user => 'root',
type => 'ssh-rsa',
key => hiera('ssh-keys::ssh-pubkey-rmoturi'),
}
notify {'SSH-KEY EDALLINP01.ELAN.ELANTECS.COM and RMOTURI-LOGIN Successfully Applied..':}

}
