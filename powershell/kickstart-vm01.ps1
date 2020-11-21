#kickstart.ps1
#Kicks downloaded fileuris to run inside vm under installation.

 #Sets the local settings
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/8bc842cb600fa070403a41b7a7e443b9/raw/59f4a58630692523332f50a84308fa4d6d4459cb/Setlocals.ps1')"

#Install ftp server an iis
 powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/f51abfa76fa81af83acd81f653cf58ab/raw/e5c80711d8def4676cb9cc46fab06590572b7341/ftp-install-configure.ps1')"


 
