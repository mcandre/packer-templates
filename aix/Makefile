.PHONY: install-boxes install-box-virtualbox

IMG="IBM AIX-PS2 1.3 (3.5)/Base_Operating_System_01.img"

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: aix-virtualbox.box
	vagrant box add -f mcandre/aix $(BOX)

aix-virtualbox.box: aix.json *.sh $(IMG) Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso aix.json

$(IMG).7z:
	wget "http://julian.winworldpc.com/Abandonware%20Operating%20Systems/PC/Misc/IBM%20AIX-PS2%201.3%20(3.5).7z"

$(IMG): $(IMG).7z
	7z x $(IMG).7z

clean: clean-boxes clean-vagrant clean-artifacts clean-imgs

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

clean-imgs:
	-rm -rf "IBM AIX-PS2 1.3 (3.5)"
	-rm -rf *.7z

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
