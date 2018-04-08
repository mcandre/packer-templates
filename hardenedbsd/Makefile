.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: hardenedbsd-virtualbox.box
	vagrant box add -f --name mcandre/hardenedbsd --provider virtualbox hardenedbsd-virtualbox.box

hardenedbsd-virtualbox.box: hardenedbsd.json http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso hardenedbsd.json

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
