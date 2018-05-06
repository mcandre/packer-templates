.PHONY: install-boxes install-box-i386-virtualbox

all: install-boxes

install-boxes: install-box-i386-virtualbox

install-box-i386-virtualbox: freedos-i386-virtualbox.box
	vagrant box add -f --name mcandre/freedos-i386 --provider virtualbox freedos-i386-virtualbox.box

freedos-i386-virtualbox.box: freedos-i386.json http/*.bat *.bat
	PACKER_LOG=1 packer build -force -only virtualbox-iso freedos-i386.json

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
