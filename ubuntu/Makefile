.PHONY: install-box-virtualbox

all: install-box-virtualbox

install-box-virtualbox: ubuntu-virtualbox.box
	vagrant box add -f --name mcandre/ubuntu --provider virtualbox ubuntu-virtualbox.box

ubuntu-virtualbox.box: ubuntu.json *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso ubuntu.json

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
