# Run as Administrator
Write-Host "🔧 Installing OCI CLI on Windows..."
Invoke-WebRequest -Uri https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1 -OutFile install.ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
.\install.ps1
Write-Host "✅ OCI CLI installed. Run 'oci setup config'"
