# Run as Administrator
Write-Host "🔧 Installing AWS CLI v2..."
Invoke-WebRequest -Uri https://awscli.amazonaws.com/AWSCLIV2.msi -OutFile AWSCLIV2.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AWSCLIV2.msi /quiet'
Remove-Item AWSCLIV2.msi
Write-Host "✅ AWS CLI installed. Run 'aws configure'"
