Get-User -ResultSize unlimited -Filter 'RemotePowerShellEnabled -eq $true' >> .\NoPowerShell.txt
#Pause to remove auhtorized admins from the list
$NPS = Get-Content ".\NoPowerShell.txt"
$NPS | ForEach-Object {Set-User -Identity $_ -RemotePowerShellEnabled $false}
#Validate that only authorized Admins have EXO Remote PS enabled
Get-User -ResultSize unlimited -Filter 'RemotePowerShellEnabled -eq $true'
#Continue if complete

Get-PSSession | Remove-PSSession #Close ExO PowerShell Session
