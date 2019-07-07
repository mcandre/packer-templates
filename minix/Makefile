.PHONY: install-boxes install-box-virtualbox

ISO=minix_R3.4.0rc6-d5e4fc0.iso

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: minix-virtualbox.box
	vagrant box add -f mcandre/minix $(BOX)

minix-virtualbox.box: minix.json *.sh $(ISO) Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso minix.json

$(ISO).bz2:
	wget http://download.minix3.org/iso/snapshot/minix_R3.4.0rc6-d5e4fc0.iso.bz2

$(ISO): $(ISO).bz2
	bunzip2 -k $(ISO).bz2

clean: clean-packer clean-boxes clean-vagrant clean-artifacts clean-isos

clean-packer:
	-rm crash.log

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

clean-isos:
	-rm -rf *.iso
	-rm -rf *.bz2

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
