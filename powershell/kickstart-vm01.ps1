 New-Item -Path "c:\" -Name "transcripts" -ItemType "directory"
Start-Transcript -Path "C:\transcripts\transcript0.txt" -NoClobber
 



#kickstart.ps1
#Kicks downloaded fileuris to run inside vm under installation.

 #Sets the local settings
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/8bc842cb600fa070403a41b7a7e443b9/raw/59f4a58630692523332f50a84308fa4d6d4459cb/Setlocals.ps1')"

#Install ftp server an iis
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/f51abfa76fa81af83acd81f653cf58ab/raw/09cf73a07ed76ef6eebdafffb6ddccc180c4ef61/ftp-install-configure.ps1')"



 #Adds install open VPN and the task for open vpn
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/753858a5cfcb1b99ca1427ef37de6b22/raw/596daaffdc501d889bc36ca33555806cd3ae8be2/openvpn.ps1"


   # Adds Choco
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/f1eca56cfff4d741ff87261591343e69/raw/f7ba7c8f3d2e54911dd60ac5d4308f6e8be1939c/getchoco.ps1')"
 
 #Install modules from Choco

 #powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/9a4106ba9fefd2cfc333bcf4a0dd04de/raw/663b88e4fe9e0b98949a5f62eb1031a562b27a30/moduldeschoco.ps1')"



 
 Stop-Transcript 
