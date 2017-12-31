Vagrant.configure("2") do |config|
  config.vm.guest = :netbsd
  config.ssh.shell = "/bin/sh"
  config.ssh.sudo_command = "su -l root -c '%c'"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
end
