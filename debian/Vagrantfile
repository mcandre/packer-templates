Vagrant.configure("2") do |config|
    config.vm.synced_folder ".", "/vagrant", type: "rsync"
    config.vm.provider :libvirt do |v|
        v.driver = "qemu"
        v.machine_arch = "ppc64le"
        v.machine_type = "pseries"
        v.cpu_mode = "custom"
        v.cpu_model = nil
        v.video_type = "vga"
    end
end
