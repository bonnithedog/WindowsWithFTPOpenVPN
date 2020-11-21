New-Item -Path "c:\" -Name "transcripts" -ItemType "directory"
Start-Transcript -Path "C:\transcripts\transcript0.txt" -NoClobber
 



#kickstart.ps1
#Kicks downloaded fileuris to run inside vm under installation.

 #Sets the local settings
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/8bc842cb600fa070403a41b7a7e443b9/raw/59f4a58630692523332f50a84308fa4d6d4459cb/Setlocals.ps1')"

#Install ftp server an iis
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/f51abfa76fa81af83acd81f653cf58ab/raw/09cf73a07ed76ef6eebdafffb6ddccc180c4ef61/ftp-install-configure.ps1')"


 #Adds install open VPN and the task for open vpn
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/753858a5cfcb1b99ca1427ef37de6b22/raw/92ff6a31437666b361bb67488d7639f0b321b912/openvpn.ps1')"
 


 #Adds install open VPN and the task for open vpn
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/753858a5cfcb1b99ca1427ef37de6b22/raw/cc057e8c8e65ae71ef12e916764871ea68098b45/openvpn.ps1')"
 



 
 Stop-Transcript