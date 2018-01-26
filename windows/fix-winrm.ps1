$ErrorActionPreference = "Stop"

New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force
Set-NetConnectionProfile -InterfaceIndex (Get-NetConnectionProfile).InterfaceIndex -NetworkCategory Private
Set-WSManQuickConfig -Force
Set-Item WSMan:\localhost\Service\AllowUnencrypted -Value True
Set-Item WSMan:\localhost\Service\Auth\Basic -Value True
Set-Service WinRM -StartupType Automatic
Restart-Service winrm
