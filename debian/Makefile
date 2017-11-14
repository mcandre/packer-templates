.PHONY: installed-box

BOXES=debian-virtualbox.box debian-vmware.box

all: installed-box

installed-box: $(BOXES)
	vagrant box add -f --name mcandre/debian --provider virtualbox debian-virtualbox.box
	vagrant box add -f --name mcandre/debian --provider vmware_desktop debian-vmware.box

$(BOX): debian.json http/preseed.cfg *.sh
	time packer build -force debian.json

clean: clean-boxes clean-artifacts

clean-boxes:
	-rm *.box

clean-artifacts:
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
