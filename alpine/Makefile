.PHONY: install-boxes install-box-amd64-virtualbox install-box-i386-virtualbox

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-i386-virtualbox

install-box-amd64-virtualbox: alpine-amd64-virtualbox.box
	vagrant box add -f --name mcandre/alpine-amd64 --provider virtualbox alpine-amd64-virtualbox.box

install-box-i386-virtualbox: alpine-i386-virtualbox.box
	vagrant box add -f --name mcandre/alpine-i386 --provider virtualbox alpine-i386-virtualbox.box

alpine-amd64-virtualbox.box: alpine-amd64.json *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso alpine-amd64.json

alpine-i386-virtualbox.box: alpine-i386.json *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso alpine-i386.json

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
