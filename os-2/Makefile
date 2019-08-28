.PHONY: install-boxes install-box-virtualbox

ISO_7Z=/tmp/IBM_OS2_Warp_4.0.7z
ISO=/tmp/IBM_OS2_Warp_4.iso

$(ISO_7Z):
	wget -O $(ISO_7Z) "https://cloudflare-ipfs.com/ipfs/QmeT1UrCw6eiNVV8ZeaeGhxwnUHV4hiH4quLUEMVT9rdYy/IBM%20OS2%20Warp%204.0%20(CD).7z"

$(ISO): $(ISO_7Z)
	7z x -o/tmp $(ISO_7Z)
	cp "/tmp/IBM OS2 Warp 4.0 (CD)/Disk01.img" /tmp
	cp "/tmp/IBM OS2 Warp 4.0 (CD)/Disk02.img" /tmp
	cp "/tmp/IBM OS2 Warp 4.0 (CD)/Installation.img" /tmp
	cp "/tmp/IBM OS2 Warp 4.0 (CD)/IBM_OS2_Warp_4.iso" /tmp/IBM_OS2_Warp_4.iso

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: os-2-virtualbox.box
	vagrant box add -f --name mcandre/os-2 --provider virtualbox os-2-virtualbox.box

os-2-virtualbox.box: os-2.json Vagrantfile $(ISO)
	PACKER_LOG=1 packer build -force -only virtualbox-iso os-2.json

clean: clean-packer clean-boxes clean-vagrant clean-artifacts clean-install-media

clean-packer:
	-rm crash.log

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

clean-install-media:
	-rm /tmp/*.img
	-rm -rf /tmp/IBM*

lint: packer-validate

packer-validate:
	find . -name '*.json' -exec packer validate {} \;
