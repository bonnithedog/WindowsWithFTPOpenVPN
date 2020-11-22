

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
 $Group.Add($User.Path)
 
 write-host "name" $vpnusername
 write-host  "PWD" $vpnpassword 

#Download and install openVPN 
powershell wget "https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.9-I601-Win10.exe" -OutFile openvpn-install-2.4.9-i601-win10.exe
powershell Start-Process openvpn-install-2.4.9-i601-win10.exe /S -wait
 

powershell wget "https://gist.githubusercontent.com/bonnithedog/dd6e610e97d4fae5796ea9a1f307bcd7/raw/2b6830b116214d1ac1b540b0a45fa8513aaf7af0/client.ovpn" -OutFile client.ovpn
powershell wget "https://gist.githubusercontent.com/bonnithedog/b9d4b0255c26c760c50bf5dc327c966f/raw/525ddcbe8d207e1f64026646f30421f2a785c625/password.txt" -OutFile password.txt

Set-Service -Name OpenVPNService -StartupType Automatic
Set-Service -Name OpenVPNServiceInteractive -StartupType Manual 


Copy-Item "client.ovpn" -Destination "C:\Program Files\OpenVPN\config" 
Copy-Item "password.txt" -Destination "C:\Program Files\OpenVPN\config" 

#Add taskscheduler for openvpn
taskName = "OpenVPN"
user = $vpnusername
password = $vpnpassword
action = New-ScheduledTaskAction -Execute "C:\Program Files\OpenVPN\bin\openvpn-gui.exe" -Argument "--connect client.ovpn"
trigger = New-ScheduledTaskTrigger -AtStartup
settings = New-ScheduledTaskSettingsSet 
inputObject = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings 
egister-ScheduledTask -TaskName $taskName -InputObject $inputObject -User $user -Password $password 




Start-ScheduledTask -TaskName "OpenVPN"
get-ScheduledTask -TaskName "OpenVPN"