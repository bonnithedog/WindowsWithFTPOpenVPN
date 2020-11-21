#kickstart.ps1
#Kicks downloaded fileuris to run inside vm under insytallation.

powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/bonnithedog/f51abfa76fa81af83acd81f653cf58ab/raw/e5c80711d8def4676cb9cc46fab06590572b7341/ftp-install-configure.ps1')"
