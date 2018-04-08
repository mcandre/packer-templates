.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: windows-virtualbox.box
	vagrant box add -f --name mcandre/windows --provider virtualbox windows-virtualbox.box

windows-virtualbox.box: windows.json *.ps1 Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso windows.json

clean: clean-boxes clean-vagrant clean-artifacts

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

lint: packer-validate

packer-validate:
	find . -name '*.json' -exec packer validate {} \;
