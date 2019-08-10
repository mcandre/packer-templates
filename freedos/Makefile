.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: freedos-virtualbox.box
	vagrant box add -f --name mcandre/freedos --provider virtualbox freedos-virtualbox.box

freedos-virtualbox.box: freedos.json http/p *.bat
	PACKER_LOG=1 packer build -force -only virtualbox-iso freedos.json

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
