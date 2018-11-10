.PHONY: install-boxes install-box-virtualbox

IMG=HP-UX_11i_v3_DVDs
IMG_MAGNET=magnet:?xt=urn:btih:fa47aefb4e2f0c9ce7f657b3bfa6ab017d7e5c4c&dn=HP-UX_11i_v3_DVDs.7z&tr=udp://tracker.openbittorrent.com:80&tr=udp://open.demonii.com:1337&tr=udp://tracker.coppersurfer.tk:6969&tr=udp://tracker.opentrackr.org:1337/announce

all: install-boxes

install-boxes: install-box-virtualbox

install-box-virtualbox: hp-ux-virtualbox.box
	vagrant box add -f mcandre/hp-ux $(BOX)

hp-ux-virtualbox.box: hp-ux.json *.sh $(ISO) Vagrantfile
	PACKER_LOG=1 packer build -force -only virtualbox-iso hp-ux.json

$(IMG).7z:
	lftp -c torrent "$(IMG_MAGNET)"

$(IMG): $(IMG).7z
	7z x HP-UX_11i_v3_DVDs.7z

clean: clean-boxes clean-vagrant clean-artifacts clean-isos

clean-boxes:
	-rm *.box

clean-vagrant:
	-rm -rf .vagrant

clean-artifacts:
	-rm -rf packer_cache

clean-isos:
	-rm -rf HP-UX_11i_v3_DVDs
	-rm -rf *.7z

lint: packer-validate shfmt

packer-validate:
	find . -name '*.json' -exec packer validate {} \;

shfmt:
	find . -name '*.sh' -print | xargs shfmt -w -i 4
