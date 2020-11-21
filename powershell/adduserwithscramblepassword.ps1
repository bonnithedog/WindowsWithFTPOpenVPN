# Get the password
$password = powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('
https://gist.githubusercontent.com/bonnithedog/be4802ffe64215f914cbdefab13c8cef/raw/90423d5c2df89e72ff0e2f2c88766c64ce70aa60/scramblepascsword.ps1
')"


# Create an vpnuservice user 
 $ADSI = [ADSI]"WinNT://$env:ComputerName"


 $vpnusername = "sa_openvpn"
 $vpnpassword = $password
 $CreateUsersa_openvpn = $ADSI.Create("User", "$vpnusername")
 $CreateUsersa_openvpn.SetInfo()
 $CreateUsersa_openvpn.SetPassword("$vpnpassword")
 $CreateUsersa_openvpn.SetInfo()

# Add an FTP user to the group FTP Users
 $UserAccount = New-Object System.Security.Principal.NTAccount("$vpnusername")
 $SID = $UserAccount.Translate([System.Security.Principal.SecurityIdentifier])
 $Group = [ADSI]"WinNT://$env:ComputerName/Administrators,Group"
 $User = [ADSI]"WinNT://$SID"
 $Group.Add($User.Path))w-Object System.Security.Principal.NTAccount("$vpnusername")
 $SID = $UserAccount.Translate([System.Security.Principal.SecurityIdentifier])
 $Group = [ADSI]"WinNT://$env:ComputerName/Administrators,Group"
 $User = [ADSI]"WinNT://$SID"
 $Group.Add($User.Path)VPN"

# Get the password
$password = powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('
https://gist.githubusercontent.com/bonnithedog/be4802ffe64215f914cbdefab13c8cef/raw/90423d5c2df89e72ff0e2f2c88766c64ce70aa60/scramblepascsword.ps1
')"


# Create an FTP user 
 $ADSI = [ADSI]"WinNT://$env:ComputerName"


 $vpnusername = "sa_openvpn"
 $vpnusername = $password
 $CreateUsersa_openvpn = $ADSI.Create("User", "$FTPUserName")
 $CreateUsersa_openvpn.SetInfo()
 $CreateUsersa_openvpn.SetPassword("$FTPPassword")
 $CreateUsersa_openvpn.SetInfo()

# Add an FTP user to the group FTP Users
 $UserAccount = New-Object System.Security.Principal.NTAccount("$FTPUserName")
 $SID = $UserAccount.Translate([System.Security.Principal.SecurityIdentifier])
 $Group = [ADSI]"WinNT://$env:ComputerName/$FTPUserGroupName,Group"
 $User = [ADSI]"WinNT://$SID"
 $Group.Add($User.Path)