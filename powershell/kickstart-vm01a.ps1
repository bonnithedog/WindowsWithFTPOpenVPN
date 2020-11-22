 New-Item -Path "c:\" -Name "transcripts" -ItemType "directory"
Start-Transcript -Path "C:\transcripts\transcript0.txt" -NoClobber
 



#kickstart.ps1
#Kicks downloaded fileuris to run inside vm under installation.

 #Sets the local settings
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/8bc842cb600fa070403a41b7a7e443b9/raw/59f4a58630692523332f50a84308fa4d6d4459cb/Setlocals.ps1')"

#Install ftp server an iis
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/f51abfa76fa81af83acd81f653cf58ab/raw/09cf73a07ed76ef6eebdafffb6ddccc180c4ef61/ftp-install-configure.ps1')"



 #Adds install open VPN and the task for open vpn
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/05797564b6d4c97dfed06e520f8b7665/raw/d0b2486f3c2e113b7da792bab9c0d255318ea327/openvpn02.ps1')"


   # Adds Choco
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/f1eca56cfff4d741ff87261591343e69/raw/47b85111d01fd2184924cbf089ca2488320149fa/getchoco.ps1')"
 
 


 
 Stop-Transcript 
