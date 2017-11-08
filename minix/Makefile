ISO=minix_R3.3.0-588a35b.iso

BOXES=minix-virtualbox.box

all: $(BOXES)

$(BOXES): minix.json *.sh $(ISO) Vagrantfile
	time packer build -force minix.json

minix_R3.3.0-588a35b.iso.bz2:
	wget http://download.minix3.org/iso/minix_R3.3.0-588a35b.iso.bz2

$(ISO): minix_R3.3.0-588a35b.iso.bz2
	bunzip2 -k minix_R3.3.0-588a35b.iso.bz2

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
