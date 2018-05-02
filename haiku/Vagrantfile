Vagrant.configure("2") do |config|
  config.vm.guest = :smartos
  config.ssh.username = "user"
  config.vm.synced_folder ".", "/boot/vagrant-src", type: "rsync", rsync__args: ["--verbose", "--archive", "--delete", "-zz", "--copy-links"], rsync__rsync_path: "/boot/system/non-packaged/bin/pfexec rsync"
end
