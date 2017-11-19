.PHONY: install-boxes install-box-virtualbox install-box-vmware install-box-libvirt

all: install-boxes

install-boxes: install-box-virtualbox install-box-vmware install-box-libvirt

install-box-virtualbox: debian-virtualbox.box
	vagrant box add -f --name mcandre/debian --provider virtualbox debian-virtualbox.box

install-box-vmware: debian-vmware.box
	vagrant box add -f --name mcandre/debian --provider vmware_desktop debian-vmware.box

install-box-libvirt: debian-libvirt.box
	vagrant box add -f --name mcandre/debian --provider libvirt debian-libvirt.box

debian-virtualbox.box: debian.json http/preseed.cfg *.sh
	time packer build -force -only virtualbox-iso debian.json

debian-vmware.box: debian.json http/preseed.cfg *.sh
	time packer build -force -only vmware-iso debian.json

debian-libvirt.box: debian.json http/preseed.cfg *.sh
	time packer build -force -only qemu debian.json

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
