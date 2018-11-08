ISO=dfly-x86_64-5.2.1_REL.iso

.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: dragonflybsd-virtualbox.box
	vagrant box add -f --name mcandre/dragonflybsd --provider virtualbox dragonflybsd-virtualbox.box

$(ISO).bz2:
	wget https://mirror-master.dragonflybsd.org/iso-images/$(ISO).bz2

$(ISO): $(ISO).bz2
	bunzip2 $(ISO).bz2

dragonflybsd-virtualbox.box: dragonflybsd.json $(ISO) http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso -var 'iso=$(ISO)' dragonflybsd.json

clean: clean-boxes clean-vagrant clean-artifacts clean-isos

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
