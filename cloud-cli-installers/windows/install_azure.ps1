# Run as Administrator
Write-Host "🔧 Installing Azure CLI..."
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
Remove-Item AzureCLI.msi
Write-Host "✅ Azure CLI installed. Run 'az login'"
