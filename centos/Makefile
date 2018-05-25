.PHONY: boxes install-box-amd64-virtualbox install-box-i386-virtualbox

all: boxes

boxes: install-box-amd64-virtualbox install-box-i386-virtualbox

install-box-amd64-virtualbox: centos-amd64-virtualbox.box
	vagrant box add -f --name mcandre/centos-amd64 --provider virtualbox centos-amd64-virtualbox.box

install-box-i386-virtualbox: centos-i386-virtualbox.box
	vagrant box add -f --name mcandre/centos-i386 --provider virtualbox centos-i386-virtualbox.box

centos-amd64-virtualbox.box: centos-amd64.json http/ks.cfg *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso centos-amd64.json

centos-i386-virtualbox.box: centos-i386.json http/ks.cfg *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso centos-i386.json

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
