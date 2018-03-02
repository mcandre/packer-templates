.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: smartos-virtualbox.box
	vagrant box add -f --name mcandre/smartos --provider virtualbox smartos-virtualbox.box

smartos-virtualbox.box: smartos.json *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso smartos.json

clean: clean-boxes clean-artifacts clean-keys

clean-boxes:
	-rm *.box

clean-artifacts:
	-rm -rf packer_cache

clean-keys:
	-rm -rf http/*.pub

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
