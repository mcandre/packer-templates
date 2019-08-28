$ErrorActionPreference = "Stop"

choco install --force -y openssh -params '"/SSHServerFeature /KeyBasedAuthenticationFeature"'
New-Item -ItemType Directory -Force -Path "C:\\Users\\vagrant\\.ssh"
icacls "C:\\Users\\vagrant" /grant "vagrant:(OI)(CI)F"
Invoke-WebRequest -Uri "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" -Outfile "C:\\Users\\vagrant\\.ssh\\authorized_keys"

choco install --force -y git -params /GitAndUnixToolsOnPath