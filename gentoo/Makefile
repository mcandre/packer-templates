.PHONY: install-boxes install-box-amd64-virtualbox

all: install-boxes

install-boxes: install-box-amd64-virtualbox

install-box-amd64-virtualbox: gentoo-amd64-virtualbox.box
	vagrant box add -f --name mcandre/gentoo-amd64 --provider virtualbox gentoo-amd64-virtualbox.box

gentoo-amd64-virtualbox.box: gentoo-amd64.json *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso gentoo-amd64.json

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
