.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: haiku-virtualbox.box
	vagrant box add -f --name mcandre/haiku --provider virtualbox haiku-virtualbox.box

haiku-blobs/haiku-r1alpha4.1-iso.zip:
	mkdir -p haiku-blobs
	wget -O haiku-blobs/haiku-r1alpha4.1-iso.zip "http://haiku.osuosl.org/releases/r1alpha4.1/haiku-r1alpha4.1-iso.zip"

haiku-blobs/haiku-r1alpha4.iso: haiku-blobs/haiku-r1alpha4.1-iso.zip
	sh -c "cd haiku-blobs && unzip haiku-r1alpha4.1-iso.zip"

haiku-virtualbox.box: haiku-blobs/haiku-r1alpha4.iso http/shutdown http/*.patch http/*.sh http/p haiku.json *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso haiku.json

clean: clean-boxes clean-artifacts clean-blobs

clean-boxes:
	-rm *.box

clean-artifacts:
	-rm -rf packer_cache

clean-blobs:
	-rm -rf haiku-blobs

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
