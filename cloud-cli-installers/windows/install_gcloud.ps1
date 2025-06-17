# Run as Administrator
Write-Host "🔧 Installing Google Cloud CLI..."
Invoke-WebRequest -Uri https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe -OutFile GoogleCloudSDKInstaller.exe
Start-Process .\GoogleCloudSDKInstaller.exe -Wait
Remove-Item .\GoogleCloudSDKInstaller.exe
Write-Host "✅ Google Cloud CLI installed. Run 'gcloud init'"
