$When = ((Get-Date).AddDays(-3)).Date
Get-ADUser -Filter {whenCreated -ge $When} -Properties whenCreated
