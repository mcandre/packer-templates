.PHONY: installed-box

BOX=debian-virtualbox.box

all: installed-box

installed-box: $(BOX)
	vagrant box add -f mcandre/debian $(BOX)

$(BOX): debian.json http/preseed.cfg *.sh
	time packer build -force debian.json

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
