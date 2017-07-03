require 'facter'

array = []
package_data = Facter::Util::Resolution.exec('rpm -qa --qf "%{RPMTAG_NAME}\n" | grep "mcollective-*-"')

Facter.add('mcopackages') do
  confine :hostname => "edallinp01"
  setcode do
    package_data.split("\n")
  end
end
