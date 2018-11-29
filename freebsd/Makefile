.PHONY: install-boxes install-box-amd64-virtualbox install-box-i386-virtualbox

all: install-boxes

# i386 breaks on initial reboot
install-boxes: install-box-amd64-virtualbox # install-box-i386-virtualbox

install-box-amd64-virtualbox: freebsd-amd64-virtualbox.box
	vagrant box add -f --name mcandre/freebsd-amd64 --provider virtualbox freebsd-amd64-virtualbox.box

install-box-i386-virtualbox: freebsd-i386-virtualbox.box
	vagrant box add -f --name mcandre/freebsd-i386 --provider virtualbox freebsd-i386-virtualbox.box

freebsd-amd64-virtualbox.box: freebsd-amd64.json http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso freebsd-amd64.json

freebsd-i386-virtualbox.box: freebsd-i386.json http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso freebsd-i386.json

clean: clean-boxes clean-vagrant clean-artifacts

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
