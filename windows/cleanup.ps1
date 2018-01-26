$ErrorActionPreference = "Stop"

# Clean Windows startup image
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

# Clear packages
Stop-Service wuauserv
Get-ChildItem -Path 'C:\Windows\SoftwareDistribution\Download' -Recurse | Remove-Item -Force -Recurse

# Clear temporary files
try {
  Takeown /d Y /R /f "C:\Windows\Temp\*"
  Icacls "C:\Windows\Temp\*" /GRANT:r administrators:F /T /c /q  2>&1
  Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
} catch {}

#
# Disable hibernation
#

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name HiberFileSizePercent -value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -name HibernateEnabled -value 0

#
# Shrink volumes
#

Optimize-Volume -DriveLetter C

$FilePath="c:\zero.tmp"
$Volume = Get-WmiObject win32_logicaldisk -filter "DeviceID='C:'"
$ArraySize= 64kb
$SpaceToLeave= $Volume.Size * 0.05
$FileSize= $Volume.FreeSpace - $SpacetoLeave
$ZeroArray= new-object byte[]($ArraySize)

$Stream= [io.File]::OpenWrite($FilePath)
try {
  $CurFileSize = 0
  while($CurFileSize -lt $FileSize) {
    $Stream.Write($ZeroArray, 0, $ZeroArray.Length)
    $CurFileSize +=$ZeroArray.Length
  }
}
finally {
  if($Stream) {
    $Stream.Close()
  }
}

Remove-Item $FilePath
