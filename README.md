# mcandre/packer-templates: Configurations for generating Vagrant base boxes

# VAGRANT CLOUD

https://app.vagrantup.com/mcandre

# EXAMPLE

```console
$ cd debian
$ make
time packer build -force debian.json
...
      558.26 real        20.02 user         6.83 sys
$ vagrant box add -f --name mcandre/debian debian-virtualbox.box
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
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Optional

* [make](https://www.gnu.org/software/make://www.gnu.org/software/make/)
* [coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* [shfmt](https://github.com/mvdan/sh) (e.g. `go get github.com/mvdan/sh/cmd/shfmt`)
