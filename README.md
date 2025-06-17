# 🌐 Cloud CLI Installers

This repository provides individual installation scripts for major cloud provider CLIs across different platforms:

- **Azure CLI**
- **Google Cloud CLI**
- **AWS CLI**
- **OCI CLI**

## 📁 Directory Structure

```
macos/
  install_azure.sh
  install_gcloud.sh
  install_aws.sh
  install_oci.sh

ubuntu/
  install_azure.sh
  install_gcloud.sh
  install_aws.sh
  install_oci.sh

oel/
  install_azure.sh
  install_gcloud.sh
  install_aws.sh
  install_oci.sh

windows/
  install_azure.ps1
  install_gcloud.ps1
  install_aws.ps1
  install_oci.ps1
```

## ✅ Supported Platforms

- `macOS` (via Homebrew or pkg installers)
- `Ubuntu` (apt-based)
- `Oracle Linux 8/9` (dnf/yum-based)
- `Windows` (PowerShell, run as Administrator)

## 🚀 Usage

### On Linux/macOS:
```bash
bash install_azure.sh
bash install_gcloud.sh
bash install_aws.sh
bash install_oci.sh
```

### On Windows (PowerShell as Administrator):
```powershell
./install_azure.ps1
./install_gcloud.ps1
./install_aws.ps1
./install_oci.ps1
```

## 📦 All-in-One Archive

If you're downloading the `.zip`, extract and run the scripts based on your platform.

---

Contributions welcome! PRs and suggestions for expansion (e.g., containerized installers, platform detection) are appreciated.

MIT License.
