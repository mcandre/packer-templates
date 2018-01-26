$ErrorActionPreference = "Stop"

If ( $Env:PACKER_BUILD_TYPE -eq "virtualbox-iso" ) {
  certutil -addstore -f TrustedPublisher E:\cert\oracle-vbox.cer
  E:\VBoxWindowsAdditions.exe
  eject E:
}
