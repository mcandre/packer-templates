ISO=dfly-x86_64-5.0.1_REL.iso.bz2

.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: dragonflybsd-virtualbox.box
	vagrant box add -f --name mcandre/dragonflybsd --provider virtualbox dragonflybsd-virtualbox.box

$(ISO).bz2:
	wget https://mirror-master.dragonflybsd.org/iso-images/dfly-x86_64-5.0.1_REL.iso.bz2

$(ISO): $(ISO).bz2
	bunzip2 dfly-x86_64-5.0.1_REL.iso.bz2

dragonflybsd-virtualbox.box: dragonflybsd.json $(ISO) http/p *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso dragonflybsd.json

clean: clean-boxes clean-artifacts clean-isos

clean-boxes:
	-rm *.box

clean-artifacts:
	-rm -rf packer_cache

clean-isos:
	-rm *.iso
	-rm *.bz2

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
