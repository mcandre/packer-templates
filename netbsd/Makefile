.PHONY: install-boxes install-box-amd64-virtualbox install-box-i386-virtualbox

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-i386-virtualbox

install-box-amd64-virtualbox: netbsd-amd64-virtualbox.box
	vagrant box add -f --name mcandre/netbsd-amd64 --provider virtualbox netbsd-amd64-virtualbox.box

install-box-i386-virtualbox: netbsd-i386-virtualbox.box
	vagrant box add -f --name mcandre/netbsd-i386 --provider virtualbox netbsd-i386-virtualbox.box

netbsd-amd64-virtualbox.box: netbsd-amd64.json http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso netbsd-amd64.json

netbsd-i386-virtualbox.box: netbsd-i386.json http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso netbsd-i386.json

clean: clean-packer clean-boxes clean-vagrant clean-artifacts

clean-packer:
	-rm crash.log

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
