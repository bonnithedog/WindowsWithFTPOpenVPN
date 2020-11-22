 #Download and install Chocolate 

powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')"

Invoke-Command {& cmd /c "C:\ProgramData\chocolatey\choco.exe" `install google-backup-and-sync -y -v -n`}





