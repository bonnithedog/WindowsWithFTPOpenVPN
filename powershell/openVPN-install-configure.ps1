

#Download and install openVPN 
powershell wget "https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.9-I601-Win10.exe" -OutFile openvpn-install-2.4.9-i601-win10.exe
powershell Start-Process openvpn-install-2.4.9-i601-win10.exe /S -wait
 
 #Add taskscheduler for openvpn
$taskName = "OpenVPN"
$user = "tfadmin"
$password = "S3cr3ts24"
$action = New-ScheduledTaskAction -Execute "C:\Program Files\OpenVPN\bin\openvpn-gui.exe" -Argument "--connect OVPN - client.ovpn"
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet 
$inputObject = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings 
Register-ScheduledTask -TaskName $taskName -InputObject $inputObject -User $user -Password $password 
 
 
powershell wget "https://gist.githubusercontent.com/bonnithedog/dd6e610e97d4fae5796ea9a1f307bcd7/raw/b902c87d7a2f0f390e2fce2f158ca8a3160f65dc/client.ovpn" -OutFile client.ovpn
Copy-Item "client.ovpn" -Destination "C:\Program Files\OpenVPN\config" 
Copy-Item "passord.txt" -Destination "C:\Program Files\OpenVPN\config" 