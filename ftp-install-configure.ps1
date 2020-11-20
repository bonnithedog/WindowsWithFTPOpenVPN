 
 
New-Item -Path "c:\" -Name "transcripts" -ItemType "directory"
Start-Transcript -Path "C:\transcripts\transcript0.txt" -NoClobber
 
# https://4sysops.com/archives/install-and-configure-an-ftp-server-with-powershell/

# Install the Windows feature for FTP
Install-WindowsFeature Web-FTP-Server -IncludeAllSubFeature
Install-WindowsFeature Web-Server -IncludeAllSubFeature -IncludeManagementTools

# Import the module
Import-Module WebAdministration

 #Creates the folders
 New-Item -Path "c:\" -Name "webpub" -ItemType "directory"
 New-Item -Path "c:\webpub\" -Name "DCS-2330L" -ItemType "directory"
 New-Item -Path "c:\webpub\" -Name "DCS-935L" -ItemType "directory"
 New-Item -Path "c:\" -Name "configtemp" -ItemType "directory"
 
 
 
 
 # Create the FTP site
 $FTPSiteName = 'Default FTP Site'
 $FTPRootDir = 'C:\webpub'
 $FTPPort = 21
 New-WebFtpSite -Name $FTPSiteName -Port $FTPPort -PhysicalPath $FTPRootDir
 
 
 
 # Create the local Windows group
 $FTPUserGroupName = "FTP Users"
 $ADSI = [ADSI]"WinNT://$env:ComputerName"
 $FTPUserGroup = $ADSI.Create("Group", "$FTPUserGroupName")
 $FTPUserGroup.SetInfo()
 $FTPUserGroup.Description = "Members of this group can connect through FTP"
 $FTPUserGroup.SetInfo()
 
 # Create an FTP user
 $FTPUserName = "FTPUser"
 $FTPPassword = 'Ludvig@W0rk'
 $CreateUserFTPUser = $ADSI.Create("User", "$FTPUserName")
 $CreateUserFTPUser.SetInfo()
 $CreateUserFTPUser.SetPassword("$FTPPassword")
 $CreateUserFTPUser.SetInfo()
 
 # Add an FTP user to the group FTP Users
 $UserAccount = New-Object System.Security.Principal.NTAccount("$FTPUserName")
 $SID = $UserAccount.Translate([System.Security.Principal.SecurityIdentifier])
 $Group = [ADSI]"WinNT://$env:ComputerName/$FTPUserGroupName,Group"
 $User = [ADSI]"WinNT://$SID"
 $Group.Add($User.Path)
 
 # Enable basic authentication on the FTP site
 $FTPSitePath = "IIS:\Sites\$FTPSiteName"
 $BasicAuth = 'ftpServer.security.authentication.basicAuthentication.enabled'
 Set-ItemProperty -Path $FTPSitePath -Name $BasicAuth -Value $True
 # Add an authorization read rule for FTP Users.
 $Param = @{
     Filter   = "/system.ftpServer/security/authorization"
     Value    = @{
         accessType  = "Allow"
         roles       = "$FTPUserGroupName"
         permissions = 2
     }
     PSPath   = 'IIS:\'
     Location = $FTPSiteName
 }
 Add-WebConfiguration @param
 
 $SSLPolicy = @(
     'ftpServer.security.ssl.controlChannelPolicy',
     'ftpServer.security.ssl.dataChannelPolicy'
 )
 Set-ItemProperty -Path $FTPSitePath -Name $SSLPolicy[0] -Value $false
 Set-ItemProperty -Path $FTPSitePath -Name $SSLPolicy[1] -Value $false
 
 
 $UserAccount = New-Object System.Security.Principal.NTAccount("$FTPUserGroupName")
 $AccessRule = [System.Security.AccessControl.FileSystemAccessRule]::new($UserAccount,
     'FullControl',
     'ContainerInherit,ObjectInherit',
     'None',
     'Allow'
 )
 $ACL = Get-Acl -Path $FTPRootDir
 $ACL.SetAccessRule($AccessRule)
 $ACL | Set-Acl -Path $FTPRootDir
 
     
 # Restart the FTP site for all changes to take effect
 Restart-WebItem "IIS:\Sites\$FTPSiteName" -Verbose
 
 
 #New-NetFirewallRule -DisplayName "Allow Innbound Ppassive mode port range. Usually (60000-60100)" -Direction Inbound -LocalPort 60000-60100 -Protocol TCP -Action Allow
  
 #Set-WebConfiguration "/system.ftpServer/firewallSupport" -PSPath "IIS:\" -Value @{lowDataChannelPort="60000";highDataChannelPort="60100";}
 
 #Set up data channel
 Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.ftpServer/firewallSupport" -name "lowDataChannelPort" -value 60000
 Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.ftpServer/firewallSupport" -name "highDataChannelPort" -value 60100
 
 
 #Set external firewall support
 Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults/ftpServer/firewallSupport" -name "externalIp4Address" -value "1.1.1.1"
 
 Get-IISConfigSection -SectionPath "system.ftpServer/firewallSupport" 
 
 
 Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content) -OutFile c:\configtemp\publicipinfo.json
 $ipvalue = (Get-Content 'c:\configtemp\publicipinfo.json' | ConvertFrom-Json).ip
 
 Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults/ftpServer/firewallSupport" -name "externalIp4Address" -value $ipvalue
 
 $data = Get-Content "c:\configtemp\publicipinfo.json" | Out-String | ConvertFrom-Json
 
 
 Restart-Service ftpsvc  


 https://chocolatey.org/install.ps1

 #Download and install Chocolate 
powershell wget "https://chocolatey.org/install.ps1" -OutFile choco.ps1
powershell .\choco.ps1
cmd choco install google-backup-and-sync


#Download and install openVPN 
powershell wget "https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.9-I601-Win10.exe" -OutFile openvpn-install-2.4.9-i601-win10.exe
powershell Start-Process openvpn-install-2.4.9-i601-win10.exe /S -wait
 
 #Add taskscheduler for openvpn
$taskName = "OpenVPN"
$user = "*****"
$password = "******"
$action = New-ScheduledTaskAction -Execute "C:\Program Files\OpenVPN\bin\openvpn-gui.exe" -Argument "--connect OVPN - client.ovpn"
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet 
$inputObject = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings 
Register-ScheduledTask -TaskName $taskName -InputObject $inputObject -User $user -Password $password 
 
 
powershell wget "https://gist.githubusercontent.com/bonnithedog/dd6e610e97d4fae5796ea9a1f307bcd7/raw/b902c87d7a2f0f390e2fce2f158ca8a3160f65dc/client.ovpn" -OutFile client.ovpn
Copy-Item "client.ovpn" -Destination "C:\Program Files\OpenVPN\config" 
Copy-Item "passord.txt" -Destination "C:\Program Files\OpenVPN\config" 



 ##Gets backupandysnc from google
 #powershell wget "https://dl.google.com/tag/s/appguid%3D%7B3C122445-AECE-4309-90B7-85A6AEF42AC0%7D%26iid%3D%7B9648D435-67BA-D2A7-54D2-1E0B5656BF03%7D%26ap%3Duploader%26appname%3DBackup%2520and%2520Sync%26needsadmin%3Dtrue/drive/installbackupandsync.exe" -OutFile installbackupandsync.exe
 #powershell Start-Process installbackupandsync.exe 

 #Start-Process nohup 'installbackupandsync.exe -noprofile -c "1..120 | % { Write-Host . -NoNewline; sleep 1 }"'
 
 
 Stop-Transcript
 
