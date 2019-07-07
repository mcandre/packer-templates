.PHONY: install-boxes install-box-amd64-virtualbox install-box-ppc64el-libvirt

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-ppc64el-libvirt

install-box-amd64-virtualbox: ubuntu-amd64-virtualbox.box
	vagrant box add -f --name mcandre/ubuntu-amd64 --provider virtualbox ubuntu-amd64-virtualbox.box

install-box-ppc64el-libvirt: ubuntu-ppc64el-libvirt.box
	vagrant box add -f --name mcandre/ubuntu-ppc64el --provider libvirt ubuntu-ppc64el-libvirt.box

ubuntu-amd64-virtualbox.box: ubuntu-amd64.json *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso ubuntu-amd64.json

ubuntu-ppc64el-libvirt.box: ubuntu-ppc64el.json *.sh
	PACKER_LOG=1 packer build -force -only qemu ubuntu-ppc64el.json

clean: clean-packer clean-boxes clean-vagrant clean-artifacts

clean-packer:
	-rm crash.log

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
