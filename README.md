# mcandre/packer-templates: Configurations for generating Vagrant base boxes

# VAGRANT CLOUD

https://app.vagrantup.com/mcandre

# EXAMPLE

```console
$ cd debian
$ make
time packer build -force debian.json
...
      529.04 real        20.08 user        11.78 sys
vagrant box add -f --name mcandre/debian --provider virtualbox debian-virtualbox.box
vagrant box add -f --name mcandre/debian --provider vmware debian-vmware.box
...

$ vagrant box list
mcandre/debian (virtualbox, 0)
mcandre/debian (vmware_desktop, 0)

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
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [VMware](https://www.vmware.com/) (e.g. Player, Fusion, Workstation)
* [bzip2](http://www.bzip.org)
* [wget](https://www.gnu.org/software/wget/)

## Optional

* [make](https://www.gnu.org/software/make://www.gnu.org/software/make/)
* [coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* [shfmt](https://github.com/mvdan/sh) (e.g. `go get github.com/mvdan/sh/cmd/shfmt`)
