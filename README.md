# Windows WithFTP and OpenVPN


This project use a Windows VM with bootstrapping software install.

There is a script which need to be available on for the VM to install software.
In this example there is used a public blob storage in azure for test purpose.
This setup includes password in the powershellscript and should not be used as production setup.

Used with terraform cloud https://www.terraform.io/cloud where this variables are set:

```bash
#Terraform Variables
web-windows-vm-size
web-windows-admin-password
web-windows-admin-username

#Environment Variables
ARM_CLIENT_ID
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID
ARM_CLIENT_SECRET
```
KE
