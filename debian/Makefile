BOXES=debian-virtualbox.box

all: $(BOXES)

$(BOXES): debian.json
	packer build -force debian.json

clean: clean-boxes clean-artifacts

clean-boxes:
	-rm *.box

clean-artifacts:
	-rm -rf packer_cache

lint: packer-validate

packer-validate:
	find . -name '*.json' -exec packer validate {} \;
