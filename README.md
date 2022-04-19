# Securre-Boot-DBX
Powershell to fix Secure Boot DBX

https://uefi.org/revocationlistfile

https://msrc.microsoft.com/update-guide/en-US/vulnerability/ADV200011

https://support.microsoft.com/en-us/topic/microsoft-guidance-for-applying-secure-boot-dbx-update-kb4575994-e3b9e4cb-a330-b3ba-a602-15083965d9ca

https://gist.github.com/out0xb2/f8e0bae94214889a89ac67fceb37f8c0


# How to check (PS)

[System.Text.Encoding]::ASCII.GetString((Get-SecureBootUEFI db).bytes) -match 'Microsoft Corporation UEFI CA 2011'

# Download DBX

https://uefi.org/revocationlistfile

# Split DX (PS)

Install-Script -Name SplitDbxContent -Force

SplitDbxContent.ps1 .\dbxupdate_x64.bin

# Patch Secure Boot 

Set-SecureBootUefi -Name dbx -ContentFilePath .\content.bin -SignedFilePath .\signature.p7 -Time 2010-03-06T19:17:21Z -AppendWrite



