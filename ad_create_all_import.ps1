#Enter a path to your import CSV file
$ADUsers = Import-csv C:\Users\Administrator\Downloads\all_adusers.csv

foreach ($User in $ADUsers)
{

       $Password    = "Qawsed123!"
       $Status      = [int]$User.Enabled
       $Firstname   = $User.GivenName
       $Lastname    = $User.Surname
       $Telephone   = $User.telephoneNumber
       $UPName      = $User.UserPrincipalName
       $Email       = $User.mail
       $Job         = $User.title
       $Department  = $User.department
       $Company     = $User.company
       $Username    = $User.samAccountName
       $OU          = $User.DN

       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
               #If user does exist, output a warning message
               Write-Warning "A user account $Username has already exist in Active Directory."
       }
       else
       {
              #If a user does not exist then create a new user account
          
        #Account will be created in the OU listed in the $OU variable in the CSV file; don’t forget to change the domain name in the"-UserPrincipalName" variable
              New-ADUser `
            -Enabled $Status `
            -GivenName "$Firstname" `
            -Surname "$Lastname" `
            -DisplayName "$Firstname $Lastname" `
            -Name "$Firstname $Lastname" `
            -OfficePhone "$Telephone" `
            -MobilePhone "$Telephone" `
            -UserPrincipalName "$UPName" `
            -EmailAddress "$Email" `
            -Title "$Job" `
            -Department "$Department" `
            -Company "$Company" `
            -SamAccountName "$Username" `
            -Path $OU `
            -ChangePasswordAtLogon $True `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)

       }
}