.PHONY: installed-box

ISO=minix_R3.4.0rc6-d5e4fc0.iso

BOXES=minix-virtualbox.box minix-vmware.box

all: installed-box

installed-box: $(BOXES)
	vagrant box add -f --name mcandre/minix --provider virtualbox minix-virtualbox.box
	vagrant box add -f --name mcandre/minix --provider vmware_desktop minix-vmware.box

$(BOXES): minix.json *.sh $(ISO) Vagrantfile
	time packer build -force minix.json

$(ISO).bz2:
	wget http://download.minix3.org/iso/snapshot/minix_R3.4.0rc6-d5e4fc0.iso.bz2

$(ISO): $(ISO).bz2
	bunzip2 -k $(ISO).bz2

clean: clean-boxes clean-artifacts clean-isos

clean-boxes:
	-rm *.box

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
