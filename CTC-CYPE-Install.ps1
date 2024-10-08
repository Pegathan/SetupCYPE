# To execute this script in Restricted mode, open Powershell as admin and execute the following command before running the script
# PowerShell -ExecutionPolicy Bypass

Write-Output "****************************************"
Write-Output "* CTC-CYPE mandatory softwares install *"
Write-Output "****************************************"

# Chocolatey install
Write-Output "1.Chocolatey install"
try
{
    choco -v | Out-Null
    Write-Output "Chocolatey already installed"
}
catch [System.Management.Automation.CommandNotFoundException]
{
    Write-Output "Chocolatey not installed on system - installation in progress"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

# Git install
Write-Output "2.Git install"
try
{
    git -v | Out-Null
    Write-Output "Git already installed"
}
catch [System.Management.Automation.CommandNotFoundException]
{
    Write-Output "Git not installed on system - installation in progress"
    choco install git -y
}

# Docker Desktop Install
Write-Output "3.Docker Desktop install"
if ((Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | select DisplayName,DisplayVersion | where {$_.DisplayName -like "Docker*"}) -eq $null) {
    Write-Output "Docker Desktop not installed on system - installation in progress"
    choco install docker-desktop -y
} else {
    Write-Output "Docker Desktop already installed"
}

# Visual Studio Code install
Write-Output "4.Visual Studio Code install"
try
{
    code -v | Out-Null
    Write-Output "VSC already installed"
}
catch [System.Management.Automation.CommandNotFoundException]
{
    Write-Output "Visual Studio Code not installed on system - installation in progress"
    choco install vscode -y
    refreshenv
}

# Visual Studio Code extensions install
Write-Output "5.Visual Studio Code extensions install"
code --install-extension ms-azuretools.vscode-docker
code --install-extension GitHub.vscode-pull-request-github

# GNU Make install
Write-Output "6.GNU Make install"
try
{
    make -v | Out-Null
    Write-Output "GNU Make already installed"
}
catch [System.Management.Automation.CommandNotFoundException]
{
    Write-Output "GNU Make not installed on system - installation in progress"
    choco install make -y
}

# .wslconfig file 
Write-Output "7.wslconfig file param"

$wslConfig = "[wsl2]"+"`nkernelCommandLine = `"sysctl.vm.max_map_count=262144`""
if (!(Test-Path $env:USERPROFILE\.wslconfig)) {
    New-Item -Path $env:USERPROFILE -Name .wslconfig | Out-Null
    Add-Content -Path $env:USERPROFILE\.wslconfig -Value $wslConfig
} elseif ((Select-String -Path $env:USERPROFILE\.wslconfig -Pattern "sysctl.vm.max_map_count") -eq $null) {
    Add-Content -Path $env:USERPROFILE\.wslconfig -Value $wslConfig
}

# GitHub CLI install
Write-Output "8.GitHub CLI"
try
{
    gh version | Out-Null
    Write-Output "GitHub CLI already installed"
}
catch [System.Management.Automation.CommandNotFoundException]
{
    Write-Output "GitHub CLI not installed on system - installation in progress"
    choco install gh -y
}

Write-Output "***************************************************"
Write-Output "* Install finished - please restart your computer *"
Write-Output "***************************************************"