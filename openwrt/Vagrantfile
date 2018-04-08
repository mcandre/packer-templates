Vagrant.configure("2") do |config|
  config.vm.guest = :linux
  config.ssh.shell = "/bin/ash"
  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__args: ["--verbose", "--archive", "--delete", "-zz", "--copy-links"], rsync__chown: false
end
