Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |libvirt|
    config.vm.synced_folder ".", "/vagrant", type: "rsync"
  end
end
