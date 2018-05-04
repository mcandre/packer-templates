# RUNTIME REQUIREMENTS

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

## Synced folders note

This box requires an additional explicit chown to fix guest file permissions:

```console
$ vagrant ssh -c "sudo find /vagrant -exec chown vagrant:vagrant {} +"
```

# BUILDTIME REQUIREMENTS

* [VirtualBox](https://www.virtualbox.org/)
* [packer](https://www.packer.io/) 1.2.0+

## Recommended extras

* [Taurine](https://itunes.apple.com/us/app/taurine/id960276676?mt=12) / [Caffeine for Windows](http://www.zhornsoftware.co.uk/caffeine/) / [Caffeine for Ubuntu](https://launchpad.net/caffeine) to prevent host from hibernating during long packer builds

# BUILD

```console
$ make install-boxes
```
