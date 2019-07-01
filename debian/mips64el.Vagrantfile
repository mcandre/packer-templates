Vagrant.configure("2") do |config|
    config.vm.synced_folder ".", "/vagrant", type: "rsync"

    config.vm.provider :libvirt do |v|
        v.machine_arch = "mips64el"
        v.machine_type = "mipssim"
        v.cpu_mode = "custom"
        v.cpu_model = nil
        v.video_type = "vga"
    end
end
