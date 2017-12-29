# mcandre/packer-templates: Configurations for generating Vagrant base boxes

# VAGRANT CLOUD

https://app.vagrantup.com/mcandre

# EXAMPLE

```console
$ cd debian
$ time make install-box-virtualbox
packer build -force -only virtualbox-iso debian.json

...

      529.04 real        20.08 user        11.78 sys

vagrant box add -f --name mcandre/debian --provider virtualbox debian-virtualbox.box

...

$ vagrant box list
mcandre/debian                           (virtualbox, 0)

$ cd test
$ vagrant up
$ vagrant ssh -c 'uname -a'
Linux debian 4.9.0-4-amd64 #1 SMP Debian 4.9.51-1 (2017-09-28) x86_64 GNU/Linux
$ vagrant ssh -c 'ls /vagrant'
bootstrap.sh  flag.txt	Vagrantfile
```

# REQUIREMENTS

* [Packer](https://www.packer.io/)
* [Vagrant](https://www.vagrantup.com/)
* [bzip2](http://www.bzip.org)
* [wget](https://www.gnu.org/software/wget/)

## Providers/Hypervisors

Some packer templates support multiple hypervisor options. By default, Packer will attempt to target all configured hypervisors. Or, if you are interested in merely a subset of the hypervisors, ensure that the `-only <comma,separated,providers>` flag is specified to the `packer build`... command.

Regardless of provider, be sure to change directory to the guest OS desired (e.g. `debian/`), as Packer builds are relative to the current working directory, rather than relative to the packer JSON directory.

### VirtualBox

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

One cleanup tip: As with all Vagrant hypervisors, VirtualBox sometimes leaves virtual machine data around when `vagrant destroy [-f]`, or a signal interrupted `vagrant up` should have deleted these artifacts. When this happens, the user can launch the VirtualBox application and delete these files manually. VirtualBox will likely complain with multiple error prompts, but these can largely be ignored.

### VMware

* vagrant-vmware-fusion/vagrant-vmware-workstation with a [license](https://www.vagrantup.com/docs/vmware/installation.html) installed
* [VMware](https://www.vmware.com/) (e.g. Player, Fusion, Workstation)

VMware boxes can be packed without a Vagrant plugin, but running the boxes to test them requires a paid license, even for users who have already paid for VMware. Go figure.

### qemu/libvirt

* [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)
* [qemu](https://www.qemu.org/) with SDL(2) enabled

qemu AKA libvirt boxes are fragile, requiring more care than VirtualBox or VMware providers. libvirt support for macOS hosts is nascent, so packing and running libvirt boxes is best performed from Linux hosts such as Debian, Ubuntu, or RHEL derivatives. qemu is slower than other hypervisors, especially when KVM is unavailable. This dramatically increases the time required for both packing and running qemu/libvirt boxes. Read: `vagrant up --provider libvirt && vagrant ssh -c 'uname -a'` for mcandre/debian takes several minutes, and `packer build -only qemu debian.json` takes over 3 hours. Speed demon!

The process for properly installing the vagrant-libvirt plugin is rather involved, requiring multiple separate packages to be setup. See the vagrant-libvirt [README](https://github.com/vagrant-libvirt/vagrant-libvirt/blob/master/README.md) for more detail.

Once vagrant-libvirt is fully installed with native extensions, the host should be configured to avoid hibernation for at least 4 hours, in order to ensure that the packer build completes without network interruption.

In addition, libvirt requires additional manual configuration in order to correctly integrate with Vagrant via vagrant-libvirt:

* The libvirt-bin and libvirt-guests services should be running. Consult your host operating system's init system.
* The user running Vagrant must have sufficient permission to access the libvirt socket, such as adding the user to the `libvirtd` UNIX group.
* Guest operating systems must name their network adapters according to the legacy Linux scheme in order to integrate with vagrant-libvirt and obtain an IP address. See fix-libvirt-networking.debian.sh in debian/ for an example GRUB configuration to enforce this policy in the guest OS at packing time.
* libvirt may come preconfigured with extraneous networks and volumes that conflict with vagrant-libvirt. See `virsh net-list` and `virsh vol-list --pool default` to examine these resources.

## Optional

* [make](https://www.gnu.org/software/make://www.gnu.org/software/make/)
* [coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* [shfmt](https://github.com/mvdan/sh) (e.g. `go get github.com/mvdan/sh/cmd/shfmt`)
