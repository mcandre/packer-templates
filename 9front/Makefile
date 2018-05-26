ISO_ARCHIVE=9front-6517.dcfbb100317e.iso.gz
ISO=9front-6517.dcfbb100317e.iso

.PHONY: install-box-virtualbox

all: install-box-virtualbox

install-box-virtualbox: 9front-virtualbox.box
	vagrant box add -f --name mcandre/9front --provider virtualbox 9front-virtualbox.box

$(ISO_ARCHIVE):
	wget http://9front.org/iso/9front-6517.dcfbb100317e.iso.gz

$(ISO): $(ISO_ARCHIVE)
	gunzip -k $(ISO_ARCHIVE)

9front-virtualbox.box: $(ISO) 9front.json http/p *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso 9front.json

clean: clean-boxes clean-vagrant clean-artifacts clean-isos

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

clean-isos:
	-rm *.iso
	-rm *.gz

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
