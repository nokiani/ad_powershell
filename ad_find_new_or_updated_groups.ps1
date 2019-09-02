$When = ((Get-Date).AddDays(-3)).Date
Get-ADGroup -Filter {whenChanged -ge $When} -Properties whenChanged
