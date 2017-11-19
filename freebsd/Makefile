.PHONY: install-boxes install-box-virtualbox

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: freebsd-virtualbox.box
	vagrant box add -f --name mcandre/freebsd --provider virtualbox freebsd-virtualbox.box

freebsd-virtualbox.box: freebsd.json http/installerconfig *.sh Vagrantfile
	time packer build -force -only virtualbox-iso freebsd.json

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
