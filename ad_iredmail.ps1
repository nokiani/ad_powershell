function Get-RandPasswd($length) {

  function Get-RandomCharacters($length, $characters) {
      $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
      $private:ofs=""
      return [String]$characters[$random]
  }
 
  function Scramble-String([string]$inputString){     
      $characterArray = $inputString.ToCharArray()   
      $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
      $outputString = -join $scrambledStringArray
      return $outputString 
  }
 
  $password = Get-RandomCharacters -length ($length-3) -characters 'abcdefghiklmnoprstuvwxyz'
  $password += Get-RandomCharacters -length 1 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
  $password += Get-RandomCharacters -length 1 -characters '1234567890'
  $password += Get-RandomCharacters -length 1 -characters '!"§$%&/()=?}][{@#*+'
 
  #Write-Host $password $password.Length
 
  $password = Scramble-String $password
 
  return $password

}

$When = (Get-Date).AddMinutes(-360)
#$newusers = (Get-ADUser -Filter {whenCreated -ge $When} -Properties mail).mail
$newusers = (Get-ADUser -Filter {whenCreated -ge $When} -Properties *)

foreach ($user in $newusers) {

#Write-Host  ", email - "$email -ForegroundColor Red

$username = $user.Name.Trim()
$email = $user.mail.Trim()
$passw = Get-RandPasswd(8)

Write-Host "User -"$username", email - "$email", password - $passw" -ForegroundColor Green

}
