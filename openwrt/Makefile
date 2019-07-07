.PHONY: install-boxes install-box-amd64-vmware install-box-i386-vmware


all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-i386-vmware

install-box-amd64-virtualbox: openwrt-amd64-virtualbox.box
	vagrant box add -f --name mcandre/openwrt-amd64 --provider virtualbox openwrt-amd64-virtualbox.box

install-box-i386-virtualbox: openwrt-i386-virtualbox.box
	vagrant box add -f --name mcandre/openwrt-i386 --provider virtualbox openwrt-i386-virtualbox.box

openwrt-amd64-virtualbox.box: openwrt-amd64.json http/shutdown http/p1 http/p2
	PACKER_LOG=1 packer build -force -only virtualbox-iso openwrt-amd64.json

openwrt-i386-virtualbox.box: openwrt-i386.json http/shutdown http/p1 http/p2
	PACKER_LOG=1 packer build -force -only virtualbox-iso openwrt-i386.json

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
