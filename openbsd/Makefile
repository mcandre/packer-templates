.PHONY: install-boxes install-box-amd64-virtualbox install-box-i386-virtualbox

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-i386-virtualbox

install-box-amd64-virtualbox: openbsd-amd64-virtualbox.box
	vagrant box add -f --name mcandre/openbsd-amd64 --provider virtualbox openbsd-amd64-virtualbox.box

install-box-i386-virtualbox: openbsd-i386-virtualbox.box
	vagrant box add -f --name mcandre/openbsd-i386 --provider virtualbox openbsd-i386-virtualbox.box

openbsd-amd64-virtualbox.box: openbsd-amd64.json http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso openbsd-amd64.json

openbsd-i386-virtualbox.box: openbsd-i386.json http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso openbsd-i386.json

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
