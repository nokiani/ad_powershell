Get-ADUser -Filter * -SearchBase "OU=Domain Users,DC=primesource,DC=local" `
-Properties Enabled, GivenName, Surname, DisplayName, telephoneNumber, UserPrincipalName, `
mail, title, department, company, samAccountName, DistinguishedName `
| Select Enabled, GivenName, Surname, DisplayName, telephoneNumber, UserPrincipalName, mail, title, department, company, samAccountName, @{l='DN';Expression = {[regex]::Match($_.distinguishedname,",(.*)").Groups[1].Value}} `
| Export-Csv -path c:\DHCP\all_adusers.csv -NoTypeInformation -Encoding UTF8
