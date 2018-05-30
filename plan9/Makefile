ISO_ARCHIVE=plan9.iso.bz2
ISO=plan9.iso

.PHONY: install-box-virtualbox

all: install-box-virtualbox

install-box-virtualbox: plan9-virtualbox.box
	vagrant box add -f --name mcandre/plan9 --provider virtualbox plan9-virtualbox.box

$(ISO_ARCHIVE):
	wget https://9p.io/plan9/download/plan9.iso.bz2

$(ISO): $(ISO_ARCHIVE)
	bunzip2 -k $(ISO_ARCHIVE)

plan9-virtualbox.box: $(ISO) plan9.json http/p http/*.patch http/cpustart *.rc
	PACKER_LOG=1 packer build -force -only virtualbox-iso plan9.json

clean: clean-boxes clean-vagrant clean-artifacts clean-isos

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

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
