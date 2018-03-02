Vagrant.configure("2") do |config|
  config.vm.guest = :solaris11

  config.ssh.sudo_command = "pfexec %c"
  config.solaris11.suexec_cmd = "pfexec"
  config.solaris.suexec_cmd = "pfexec"

  config.vm.synced_folder ".", "/opt/vagrant", type: "rsync"
end
