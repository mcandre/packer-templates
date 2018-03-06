Vagrant.configure("2") do |config|
  config.ssh.shell = "ksh -l"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
end
