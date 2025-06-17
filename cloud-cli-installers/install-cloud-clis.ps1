# Run as Administrator
Write-Host "🔧 Installing Azure, GCP, AWS, and OCI CLI on Windows..."

# Azure CLI
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
Remove-Item AzureCLI.msi

# Google Cloud CLI
Invoke-WebRequest -Uri https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe -OutFile GoogleCloudSDKInstaller.exe
Start-Process .\GoogleCloudSDKInstaller.exe -Wait
Remove-Item GoogleCloudSDKInstaller.exe

# AWS CLI
Invoke-WebRequest -Uri https://awscli.amazonaws.com/AWSCLIV2.msi -OutFile AWSCLIV2.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AWSCLIV2.msi /quiet'
Remove-Item AWSCLIV2.msi

# OCI CLI
Invoke-WebRequest -Uri https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1 -OutFile install-oci.ps1
powershell.exe -ExecutionPolicy Bypass -File .\install-oci.ps1 -AcceptAllDefaults
Remove-Item .\install-oci.ps1

Write-Host "`n✅ All CLIs installed!"
Write-Host "Next steps:"
Write-Host "  az login"
Write-Host "  gcloud init"
Write-Host "  aws configure"
Write-Host "  oci setup config"
