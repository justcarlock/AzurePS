#Needs Work!!!!!!!
#Get User Mailboxes
Get-Mailbox -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'UserMailbox'" | -OutFile ".\UserMailBoxes.txt" -Force

$NPS = Get-Content ".\UserMailbox.txt"

$NPS | ForEach-Object {Get-Mailbox -Identity $_ | Format-List DefaultAuditSet}