# https://uefi.org/revocationlistfile
# https://msrc.microsoft.com/update-guide/en-US/vulnerability/ADV200011
# https://support.microsoft.com/en-us/topic/microsoft-guidance-for-applying-secure-boot-dbx-update-kb4575994-e3b9e4cb-a330-b3ba-a602-15083965d9ca
# https://gist.github.com/out0xb2/f8e0bae94214889a89ac67fceb37f8c0

# Check if Secure Boot is an issue 
[System.Text.Encoding]::ASCII.GetString((Get-SecureBootUEFI db).bytes) -match 'Microsoft Corporation UEFI CA 2011' | Out-File -FilePath 'c:\temp\SecureBootCheck.txt'
# Download the bin file to patch Secure boot DBX
cd c:\temp\
Invoke-WebRequest -Uri "https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin" -OutFile dbxupdate_x64.bin
# Install NuGet in case it's not on machine 
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
# Install DBX SPlitter to split the bin
Install-Script -Name SplitDbxContent -Force
#Split the bin
SplitDbxContent.ps1 "c:\temp\dbxupdate_x64.bin"
#Patch Secure Boot components 
Set-SecureBootUefi -Name dbx -ContentFilePath .\content.bin -SignedFilePath .\signature.p7 -Time 2010-03-06T19:17:21Z -AppendWrite | Out-File -FilePath 'c:\temp\SecureBootUefi.txt'
#Reboot the machine at night if left on 
#[datetime]$RestartTime = '11PM'
#[datetime]$CurrentTime = Get-Date
#[int]$WaitSeconds = ( $RestartTime - $CurrentTime ).TotalSeconds
#shutdown -r -t $WaitSeconds
