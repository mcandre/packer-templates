.PHONY: install-boxes install-box-amd64-virtualbox install-box-arm64-libvirt

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-arm64-libvirt

install-box-amd64-virtualbox: ubuntu-amd64-virtualbox.box
	vagrant box add -f --name mcandre/ubuntu-amd64 --provider virtualbox ubuntu-amd64-virtualbox.box

install-box-arm64-libvirt: ubuntu-arm64-libvirt.box
	vagrant box add -f --name mcandre/ubuntu-arm64 --provider libvirt ubuntu-arm64-libvirt.box

ubuntu-amd64-virtualbox.box: ubuntu-amd64.json *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso ubuntu-amd64.json

ubuntu-arm64-libvirt.box: ubuntu-arm64.json *.sh
	PACKER_LOG=1 packer build -force -only qemu ubuntu-arm64.json

clean: clean-boxes clean-vagrant clean-artifacts

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
