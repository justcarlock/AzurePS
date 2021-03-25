$NMB = Get-Content ".\MailboxGone.txt"

$NMB | ForEach-Object {Remove-Mailbox -Identity $_}