.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: dilos-virtualbox.box
	vagrant box add -f --name mcandre/dilos --provider virtualbox dilos-virtualbox.box

dilos-virtualbox.box: dilos.json http/postseed.sh *.sh Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso dilos.json

clean: clean-boxes clean-artifacts

clean-boxes:
	-rm *.box

clean-artifacts:
	-rm -rf packer_cache

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
