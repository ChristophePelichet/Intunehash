## Variables 

# System 
$my_Path = $MyInvocation.MyCommand.Path
$my_Drive = Split-Path $my_Path -Qualifier

# Hostname 
$my_Host = $env:computername

# Report Folder Name
$my_FolderName = "HWID"
$my_FolderPath = "$my_Drive\$my_FolderName"
$my_ReportName = "$my_Host" + "_" + "AutopilotHWID.csv"



## [Log] Create report folder
if ((Test-Path $my_FolderPath) -ne $true){ New-Item -Type Directory -Path $my_FolderPath}

# Set PSGallery repository Untrusted
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

# Get Endpoint Hash
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-Location -Path "$my_FolderPath"
$env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
Install-Script -Name Get-WindowsAutopilotInfo
Get-WindowsAutopilotInfo -OutputFile $my_ReportName

# Set PSGallery repository Untrusted
Set-PSRepository -Name "PSGallery" -InstallationPolicy Untrusted