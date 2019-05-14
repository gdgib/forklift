$ErrorActionPreference = "Stop"

if (-not (Get-Command "bash.exe" -ErrorAction SilentlyContinue)) {
	if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
		exit
	}
	
	if ([Environment]::Is64BitProcess) {
		$output = 'setup-x86_64.exe'
		$cygpath = 'C:\cygwin64\bin'
	} else {
		$output = 'setup-x86.exe'
		$cygpath = 'C:\cygwin\bin'
	}
	
	$directory = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid())
	New-Item -ItemType directory -Path "$directory"
	Set-Location -Path "$directory"
	echo "Working in $directory"
	
	$url = "https://cygwin.com/$output"
	echo "Downloading Cygwin installer"
	(New-Object System.Net.WebClient).DownloadFile($url, "$directory\$output")
	
	echo "Installing Cygwin"
	Start-Process powershell "-Command $directory\\$output -q -W --site http://cygwin.mirror.constant.com" -Verb runAs -PassThru -Wait
	
	Remove-Item -ErrorAction Ignore -Force -Recurse "$directory"
	
	$currentPath = [Environment]::GetEnvironmentVariable('path', 'machine')
	if (($currentPath).ToLower().Contains("c:\cygwin")) {
		echo "Cygwin is already on the path"
	} else {
		echo "Adding Cygwin to the path"
		[Environment]::SetEnvironmentVariable('path', "$currentPath;$cygpath", 'Machine');	
	}
}

echo "Installing forklift"
bash -l -c 'bash <(curl -L https://raw.githubusercontent.com/g2forge/forklift/master/install)'

rm $PSCommandPath
pause