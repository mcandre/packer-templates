Vagrant.configure("2") do |config|
  config.vm.guest = :haiku
  config.ssh.sudo_command = "su user -c '%c'"
  config.vm.synced_folder ".", "/boot/vagrant-src", type: "rsync"
end
