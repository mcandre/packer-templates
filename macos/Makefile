.PHONY: install-boxes install-box-vmware tmp-checksum

ISO=macos-10.13.iso
ISO_CHECKSUM=macos-10.13.iso.sha512

all: install-boxes

install-boxes: install-box-vmware

install-box-vmware: macos-vmware.box
	vagrant box add -f --name mcandre/macos --provider vmware_desktop macos-vmware.box

tmp-checksum: $(ISO_CHECKSUM)
	cp $(ISO_CHECKSUM) /tmp/$(ISO_CHECKSUM)

macos-vmware.box: macos.json tmp-checksum *.sh
	PACKER_LOG=1 time packer build -force -only vmware-iso macos.json

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
