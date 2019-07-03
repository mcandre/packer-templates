.PHONY: install-boxes install-box-amd64-virtualbox install-box-i386-virtualbox install-box-amd64-vmware install-box-i386-vmware install-box-amd64-libvirt install-box-i386-libvirt install-box-ppc64el-libvirt install-box-mips64el-libvirt

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-i386-virtualbox install-box-amd64-vmware install-box-i386-vmware install-box-amd64-libvirt install-box-i386-libvirt install-box-ppc64el-libvirt install-box-mips64el-libvirt

install-box-amd64-virtualbox: debian-amd64-virtualbox.box
	vagrant box add -f --name mcandre/debian-amd64 --provider virtualbox debian-amd64-virtualbox.box

install-box-i386-virtualbox: debian-i386-virtualbox.box
	vagrant box add -f --name mcandre/debian-i386 --provider virtualbox debian-i386-virtualbox.box

install-box-amd64-vmware: debian-amd64-vmware.box
	vagrant box add -f --name mcandre/debian-amd64 --provider vmware_desktop debian-amd64-vmware.box

install-box-i386-vmware: debian-i386-vmware.box
	vagrant box add -f --name mcandre/debian-i386 --provider vmware_desktop debian-i386-vmware.box

install-box-amd64-libvirt: debian-amd64-libvirt.box
	vagrant box add -f --name mcandre/debian-amd64 --provider libvirt debian-amd64-libvirt.box

install-box-i386-libvirt: debian-i386-libvirt.box
	vagrant box add -f --name mcandre/debian-i386 --provider libvirt debian-i386-libvirt.box

install-box-ppc64el-libvirt: debian-ppc64el-libvirt.box
	vagrant box add -f --name mcandre/debian-ppc64el --provider libvirt debian-ppc64el-libvirt.box

install-box-mips64el-libvirt: debian-mips64el-libvirt.box
	vagrant box add -f --name mcandre/debian-mips64el --provider libvirt debian-mips64el-libvirt.box

debian-amd64-virtualbox.box: debian-amd64.json http/p *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso debian-amd64.json

debian-i386-virtualbox.box: debian-i386.json http/p *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-iso debian-i386.json

debian-amd64-vmware.box: debian-amd64.json http/p *.sh
	PACKER_LOG=1 packer build -force -only vmware-iso debian-amd64.json

debian-i386-vmware.box: debian-i386.json http/p *.sh
	PACKER_LOG=1 packer build -force -only vmware-iso debian-i386.json

debian-amd64-libvirt.box: debian-amd64.json http/p *.sh
	PACKER_LOG=1 packer build -force -only qemu debian-amd64.json

debian-i386-libvirt.box: debian-i386.json http/p *.sh
	PACKER_LOG=1 packer build -force -only qemu debian-i386.json

debian-ppc64el-libvirt.box: debian-ppc64el.json http/p *.sh
	PACKER_LOG=1 packer build -force -only qemu debian-ppc64el.json

initrd.gz:
	wget http://ftp.debian.org/debian/dists/stable/main/installer-mips64el/current/images/malta/netboot/initrd.gz

vmlinux-4.9.0-9-5kc-malta:
	wget http://ftp.debian.org/debian/dists/stable/main/installer-mips64el/current/images/malta/netboot/vmlinux-4.9.0-9-5kc-malta

debian-mips64el-libvirt.box: initrd.gz vmlinux-4.9.0-9-5kc-malta debian-mips64el.json http/p *.sh
	PACKER_LOG=1 packer build -force -only qemu debian-mips64el.json

clean: clean-boxes clean-vagrant clean-artifacts

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -f vmlinux-*
	-rm -f *.gz
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
