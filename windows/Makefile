.PHONY: install-boxes install-box-amd64-virtualbox install-box-i386-virtualbox

all: install-boxes

install-boxes: install-box-amd64-virtualbox install-box-i386-virtualbox

install-box-amd64-virtualbox: windows-amd64-virtualbox.box
	vagrant box add -f --name mcandre/windows-amd64 --provider virtualbox windows-amd64-virtualbox.box

install-box-i386-virtualbox: windows-i386-virtualbox.box
	vagrant box add -f --name mcandre/windows-i386 --provider virtualbox windows-i386-virtualbox.box

windows-amd64-virtualbox.box: windows-amd64.json amd64/Autounattend.xml *.ps1 Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso windows-amd64.json

windows-i386-virtualbox.box: windows-i386.json i386/Autounattend.xml *.ps1 Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso windows-i386.json

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
