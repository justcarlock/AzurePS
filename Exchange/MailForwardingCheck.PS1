#$FormatEnumerationLimit = -1
Start-Transcript
Get-Mailbox -Filter {ForwardingAddress -ne $null -or ForwardingSmtpAddress -ne $null} | Select-Object DisplayName,ForwardingAddress,ForwardingSmtpAddress
Stop-Transcript