$NU = Get-Content ".\NewUsers.txt"

$NU | ForEach-Object {Set-MsolUserLicense -UserPrincipalName $_ -AddLicenses "<License Name>"}