# Project goal

In order to deploy and work on a complete docker environment on a Windows localhost, many softwares are required:
- Docker Desktop, for running and managing containers
- Git, for managing versions
- Visual Studio Code and extensions, a powerfull IDE to manage project and launch code
- Make, to ease deployment and execution of project

Moreover, some configuration files are mandatory in user path.

To ease install and maintenance of all previous elements, PowerShell and Chocolatey are used:
- PowerShell is Windows command-line shell 
- Chocolatey is a package-manager and installer for softwares

# Execution

1. Download ``CTC-CYPE-Install.ps1`` script and save it on your device.
2. Open PowerShell as Administrator
3. Execute this command
```
> PowerShell -ExecutionPolicy Bypass
```
4. Navigate to the folder where you saved ``CTC-CYPE-Install.ps1`` script, using ``cd`` command
5. Execute the script with this command :
```
> .\CTC-CYPE-Install.ps1
```
6. Once all components are installed, restart your computer




