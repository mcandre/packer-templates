.PHONY: install-boxes install-box-vmware

IMAGE_IMG=lede-17.01.4-x86-64-combined-ext4.img
IMAGE_ARCHIVE=lede-17.01.4-x86-64-combined-ext4.img.gz
IMAGE_ARCHIVE_CHECKSUMS=sha256sums
IMAGE_VMDK=openwrt-disk001.vmdk

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: openwrt-virtualbox.box
	vagrant box add -f --name mcandre/openwrt --provider virtualbox openwrt-virtualbox.box

$(IMAGE_ARCHIVE):
	curl -LO "https://downloads.openwrt.org/releases/17.01.4/targets/x86/64/lede-17.01.4-x86-64-combined-ext4.img.gz"

$(IMAGE_ARCHIVE_CHECKSUMS):
	curl -LO "https://downloads.openwrt.org/releases/17.01.4/targets/x86/64/sha256sums"

$(IMAGE_IMG): $(IMAGE_ARCHIVE) $(IMAGE_ARCHIVE_CHECKSUMS)
	shasum $(IMAGE_ARCHIVE_CHECKSUMS)
	gunzip -fk $(IMAGE_ARCHIVE)

$(IMAGE_VMDK): $(IMAGE_IMG)
	VBoxManage convertfromraw --format VMDK $(IMAGE_IMG) $(IMAGE_VMDK)

openwrt-virtualbox.box: openwrt.json openwrt.ovf $(IMAGE_VMDK) http/shutdown http/p *.sh
	PACKER_LOG=1 packer build -force -only virtualbox-ovf openwrt.json

clean: clean-boxes clean-vagrant clean-artifacts

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -f *.vmdk
	-rm -f *.img
	-rm -f $(IMAGE_ARCHIVE_CHECKSUMS)
	-rm -f *.gz
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
