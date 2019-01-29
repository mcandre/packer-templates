Vagrant.configure("2") do |config|
    config.vm.guest = :openbsd
    config.ssh.shell = "mksh -l"
    config.ssh.sudo_command = "sudo -H %c"
    config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__chown: false
end
