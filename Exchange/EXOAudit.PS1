# Audit Exchange Online Mailboxes
# V1.1, 14AUG20, LT Gerald Rimmer , IT1 Justin Carlock
# ***********************************************************************************************************************************
# Description: 
# ***********************************************************************************************************************************
# Dependencies: 
# 1. CSV file with UserPrincipalName set. Can be gathered using the azureADaudit.ps1 script.
# 2. Must be Exchange Admin or Global Admin
# ***********************************************************************************************************************************

Import-Module ExchangeOnlineManagement; Get-Module ExchangeOnlineManagement #Import Modules
#$EMAIL = Read-Host -Prompt '<admin>@"Tenant".onmicrosoft.us'
$START = Read-Host -Prompt 'Report start date (M/DD/YYYY) '
$END = Read-Host -Prompt 'Report end date (M/DD/YYYY) '
Write-Output "Exchange Online Report for $START to $END" 
Write-Output "****************************************************" 
Write-Output "Creating Mailbox Overview Report..." 
Get-Mailbox -ResultSize unlimited | Select-Object -Property DisplayName,PrimarySmtpAddress | Out-File -FilePath ".\ActiveMailboxes.txt"
Write-Output "Complete."
Write-Output "****************************************************" 
Write-Output "Generating ATP Overview Report..." 
Get-AtpPolicyForO365 | Out-File -FilePath ".\ExOATPOverview.txt" 
#Get ATP Overview
Write-Output "Complete."
Write-Output "****************************************************" 
Write-Output "Generating Phishing Policies and Rules Report..." 
Get-AntiPhishPolicy | Format-Table Name,Enabled,IsDefault | Out-File -FilePath ".\PhishingPolicy.txt" 
Get-AntiPhishRule | Format-Table Name,Priority,State | Out-File -FilePath ".\PhishingRules.txt" 
Write-Output "Complete."
Write-Output "****************************************************" 
Write-Output "Generating Malware Policies and Rules Report..." 
Get-MalwareFilterPolicy | Format-Table Name,Action,Enabled,IsDefault | Out-File -FilePath ".\MalwarePolicy.txt" 
Write-Output "Complete."
Write-Output "****************************************************" 
Write-Output "Generating SafeAttachment Policies and Rules Report..." 
Get-SafeAttachmentPolicy | Format-List Name,Enabled,IsDefault | Out-File -FilePath ".\SafeAttachmentPolicy.txt" 
Get-SafeAttachmentRule | Format-List Name,Enabled,IsDefault | Out-File -FilePath ".\SafeAttachmentRules.txt" 
Write-Output "Complete."
Write-Output "****************************************************" 
Write-Output "Generating SafeLink Policies and Rules..." 
#Get SafeLinkPolicy
Get-SafeLinksPolicy | Format-Table Name,IsEnabled,IsDefault | Out-File -FilePath "D:\TestScripts\Files\SafeLinksPolicy.txt" 
Get-SafeLinksRule | Format-Table -Auto Name,State,Priority,SafeLinksPolicy,Comments | Out-File -FilePath "D:\TestScripts\Files\SafeLinksRules.txt" 
Write-Output "Complete."
Write-Output "****************************************************" 
Write-Output "Verifying AutoForward Rules..." 
#Confirm Autoforward is disabled 
Set-RemoteDomain Default -AutoForwardEnabled $false
Write-Output "Complete."
Write-Output "****************************************************" 
#Pull reports
Write-Output "ATP Total Traffic Report:"
Get-ATPTotalTrafficReport | Out-File -FilePath ".\ATPTotalTrafficReport.txt" 
Write-Output "****************************************************" 
Write-Output "Mail ATP Detail Report" 
Get-MailDetailATPReport -StartDate $START -EndDate $END | Format-Table | Out-File -FilePath ".\MailDetailATPReport.txt" 
Write-Output "****************************************************" 
Write-Output "Mail ATP Document Detail Report" 
Get-AdvancedThreatProtectionDocumentDetail -StartDate $START -EndDate $END | Format-Table | Out-File -FilePath ".\AdvancedThreatProtectionDocumentDetail.txt" 
Write-Output "****************************************************" 
Write-Output "Mail ATP Protection Report" 
Get-AdvancedThreatProtectionTrafficReport -StartDate $START -EndDate $END | Format-Table | Out-File -FilePath ".\AdvancedThreatProtectionTrafficReport.txt" 
Write-Output "****************************************************" 
Write-Output "Spoof Mail Report" 
Get-SpoofMailReport -StartDate $START -EndDate $END | Format-Table | Out-File -FilePath ".\SpoofMailReport.txt"
Write-Output "****************************************************" 
Write-Output "ORCA Report"
Get-ORCAReport #Run report
Write-Output "****************************************************"
Write-Output "Verify PowerShell Disabled for non-Admins" 


Get-PSSession | Remove-PSSession #Close PowerShell Session










