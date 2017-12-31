Vagrant.configure("2") do |config|
  config.ssh.shell = "/bin/sh"
  config.ssh.sudo_command = "su -l root -c '%c'"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
end
