.PHONY: install-box-virtualbox

all: install-box-virtualbox

install-box-virtualbox: centos-virtualbox.box
	vagrant box add -f --name mcandre/centos --provider virtualbox centos-virtualbox.box

centos-virtualbox.box: centos.json http/ks.cfg *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso centos.json

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
