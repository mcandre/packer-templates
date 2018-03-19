.PHONY: install-boxes install-box-vmware

ISO=/tmp/macos-10.13.iso
ISO_CHECKSUM=/tmp/macos-10.13.iso.sha512

all: install-boxes

install-boxes: install-box-virtualbox install-box-vmware

install-box-virtualbox: macos-virtualbox.box
	vagrant box add -f --name mcandre/macos --provider virtualbox macos-virtualbox.box

install-box-vmware: macos-vmware.box
	vagrant box add -f --name mcandre/macos --provider vmware_desktop macos-vmware.box

macos-virtualbox.box: macos.json $(ISO) $(ISO_CHECKSUM) *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso macos.json

macos-vmware.box: macos.json $(ISO) $(ISO_CHECKSUM) *.sh
	PACKER_LOG=1 packer build -force -only vmware-iso macos.json

clean: clean-boxes clean-artifacts

clean-boxes:
	-rm *.box

clean-artifacts:
	-rm -rf *.sha512
	-rm -rf *.iso
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
