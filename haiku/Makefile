.PHONY: install-boxes install-box-amd64-virtualbox install-box-i386-virtualbox

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-i386-virtualbox

install-box-amd64-virtualbox: haiku-amd64-virtualbox.box
	vagrant box add -f --name mcandre/haiku-amd64 --provider virtualbox haiku-amd64-virtualbox.box

install-box-i386-virtualbox: haiku-i386-virtualbox.box
	vagrant box add -f --name mcandre/haiku-i386 --provider virtualbox haiku-i386-virtualbox.box

haiku-blobs-amd64/haiku-nightly-hrev51909-x86_64-anyboot.zip:
	mkdir -p haiku-blobs-amd64
	wget -O haiku-blobs-amd64/haiku-nightly-hrev51909-x86_64-anyboot.zip --no-use-server-timestamps "https://download.haiku-os.org/nightly-images/x86_64/haiku-nightly-hrev51909-x86_64-anyboot.zip"

haiku-blobs-i386/haiku-nightly-hrev51909-x86_gcc2_hybrid-anyboot.zip:
	mkdir -p haiku-blobs-i386
	wget -O haiku-blobs-i386/haiku-nightly-hrev51909-x86_gcc2_hybrid-anyboot.zip --no-use-server-timestamps "https://download.haiku-os.org/nightly-images/x86_gcc2_hybrid/haiku-nightly-hrev51909-x86_gcc2_hybrid-anyboot.zip"

haiku-blobs-amd64/haiku-nightly-anyboot.iso: haiku-blobs-amd64/haiku-nightly-hrev51909-x86_64-anyboot.zip
	sh -c "cd haiku-blobs-amd64 && unzip -DD haiku-nightly-hrev51909-x86_64-anyboot.zip"

haiku-blobs-i386/haiku-nightly-anyboot.iso: haiku-blobs-i386/haiku-nightly-hrev51909-x86_gcc2_hybrid-anyboot.zip
	sh -c "cd haiku-blobs-i386 && unzip -DD haiku-nightly-hrev51909-x86_gcc2_hybrid-anyboot.zip"

haiku-amd64-virtualbox.box: haiku-blobs-amd64/haiku-nightly-anyboot.iso http/*.patch http/pfexec http/sudo http/p haiku-amd64.json *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso haiku-amd64.json

haiku-i386-virtualbox.box: haiku-blobs-i386/haiku-nightly-anyboot.iso http/*.patch http/pfexec http/sudo http/p haiku-i386.json *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso haiku-i386.json

clean: clean-boxes clean-vagrant clean-artifacts clean-blobs

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

clean-blobs:
	-rm -rf haiku-blobs-amd64
	-rm -rf haiku-blobs-i386

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
