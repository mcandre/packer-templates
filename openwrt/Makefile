.PHONY: install-boxes install-box-vmware


all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: openwrt-virtualbox.box
	vagrant box add -f --name mcandre/openwrt --provider virtualbox openwrt-virtualbox.box

openwrt-virtualbox.box: openwrt.json http/shutdown http/p1 http/p2
	PACKER_LOG=1 packer build -force -only virtualbox-iso openwrt.json

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
