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
* [Vagrant](https://www.vagrantup.com/) 2.2.2+
* [bzip2](http://www.bzip.org)
* [wget](https://www.gnu.org/software/wget/)

## Recommended

* [VirtualBox](https://www.virtualbox.org/)
* [VMware](https://www.vmware.com/)
* [qemu](https://www.qemu.org/) 2.12+
* [KVM](https://wiki.qemu.org/Features/KVM)
* [OpenBIOS](https://www.openfirmware.info/OpenBIOS)
* [openhackware](https://github.com/qemu/openhackware)
* [qemu-skiboot](https://github.com/qemu/skiboot)
* [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)
* [libguestfs-tools](http://libguestfs.org/)
* [vagrant-rsync-back](https://github.com/smerrill/vagrant-rsync-back)
* [make](https://www.gnu.org/software/make/)
* [GNU findutils](https://www.gnu.org/software/findutils/)
* [stank](https://github.com/mcandre/stank) (e.g. `go get github.com/mcandre/stank/...`)
* [Python](https://www.python.org) 3+ (for yamllint)
* [Node.js](https://nodejs.org/en/) (for eclint)

Note: Windows hosts are affected by a packer bug where attempts to kill a packer process by sending a Control+C signal, result in a half-dead packer that often awakes during subsequent builds, corrupting them. Task Manager is your friend.

## Providers/Hypervisors

Some packer templates support multiple hypervisor options. By default, Packer will attempt to target all configured hypervisors. Or, if you are interested in merely a subset of the hypervisors, ensure that the `-only <comma,separated,providers>` flag is specified to the `packer build`... command.

Regardless of provider, be sure to change directory to the guest OS desired (e.g. `debian/`), as Packer builds are relative to the current working directory, rather than relative to the packer JSON directory.

Note that many packer hypervisors deliver build keystrokes via host-timed keyup, keydown pairs. This means that if your host is overloaded (CPU, RAM, HD), then packer will deliver spurious keyboard activity to the VM during a build. In particular, this often looks like repeatttttttttttted keystrokes, as the keydown event is sent too slowly to faithfully execute the `boot_command`. So whichever machine is packing VMs should have sufficient spare capacity to build: few running applications, and plenty of CPU speed, RAM, and available HD space.

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
* Finally, some libvirt guests may do a poor job persisting file changes across `vagrant package` boundaries. To work around this limitation, ensure that the file system is explicitly synchronized at the end of provisioning scripts, e.g. `sync` in GNU/Linux.

Finally, note that non-VirtualBox hypervisor builds are no longer maintained in this project.

## Optional

* a keyboard cover, in case of nearby cats that may scamper around and corrupt sensitive boot commands
* [Taurine](https://itunes.apple.com/us/app/taurine/id960276676) (macOS), [Caffeine](http://www.zhornsoftware.co.uk/caffeine/) (Windows), [Caffeine](https://launchpad.net/caffeine) (Linux) can prevent hibernation during any long builds
* [make](https://www.gnu.org/software/make://www.gnu.org/software/make/)
* [coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* [shfmt](https://github.com/mvdan/sh) (e.g. `go get github.com/mvdan/sh/cmd/shfmt`)

# TESTING

These boxes are designed as minimal bases for constructing build bot virtual machines, so that [mcandre/tonixxx](tonixxx) can use the boxes to conveniently cross-compile applications for many different kernels. The boxes are expected to feature:

* working package manager, for installation of devopment tools like gcc, curl, lua, etc.
* bidirectional-capable host->guest and guest->host synced folders, for copying source code to the box and copying artifacts back to the host, via [vagrant-rsync-back](https://github.com/smerrill/vagrant-rsync-back)

The best way to ensure that the boxes are suitable for this development workflow is to attempt to install some package, and to check that files can be copied from the host and guest and back again. This workflow is automated in a testing script. Example:

```console
$ cd debian/test
$ vagrant up
$ make test
...
```
