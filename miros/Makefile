.PHONY: install-boxes install-box-i386-virtualbox

all: install-boxes

install-boxes: install-box-i386-virtualbox

install-box-i386-virtualbox: miros-i386-virtualbox.box
	vagrant box add -f --name mcandre/miros-i386 --provider virtualbox miros-i386-virtualbox.box

http/MirOS/v10/i386/base10.ngz:
	wget -mpNHk -np -P http -nH -w 2 https://www.mirbsd.org/MirOS/v10/i386/

miros-i386-virtualbox.box: miros-i386.json http/p1 http/p2 Vagrantfile http/MirOS/v10/i386/base10.ngz
	PACKER_LOG=1 packer build -force -only virtualbox-iso miros-i386.json

clean: clean-boxes clean-vagrant clean-artifacts

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache
	-rm -rf http/MirOS

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
