# RUNTIME REQUIREMENTS

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/) 2.0.2+

# BUILDTIME REQUIREMENTS

* [VirtualBox](https://www.virtualbox.org/)
* [packer](https://www.packer.io/) with [patches](https://github.com/mcandre/packer/tree/fix-6001) for key overwrite bug

## Recommended extras

* [Taurine](https://itunes.apple.com/us/app/taurine/id960276676?mt=12) / [Caffeine for Windows](http://www.zhornsoftware.co.uk/caffeine/) / [Caffeine for Ubuntu](https://launchpad.net/caffeine) to prevent host from hibernating during long packer builds

Note: The `h` boot command is flaky, so packing may need to be rerun several times. When the `<menu>` key is finally merged to packer, this step will become more reliable.
