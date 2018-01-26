$ErrorActionPreference = "Stop"

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
