# opens VMWare

Start-Process "C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe"

Start-Sleep 5


# Define the path to vmrun.exe
$vmrun = "C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"

# List of VMX file paths for the virtual machines you want to start
$vmList = @(
    "D:\VM's\VMWare\SOC_Analyst\SOC_Analyst.vmx",
    "D:\VM's\VMWare\Kali\kali-linux-2024.4-vmware-amd64.vmx",
    "D:\VM's\VMWare\Pfsense\Pfsense.vmx",
    "D:\VM's\VMWare\Sec Onion\Security Onion.vmx",
    "D:\VM's\VMWare\SIEM\SIEM.vmx",
    "D:\VM's\VMWare\Windows 10\Windows 10.vmx",
    "D:\VM's\VMWare\Windows Server 2022\Windows Server 2022.vmx"
)

# Function to check if a VM is already running
function test-VMRunning {
    param (
        [string]$vmxPath
    )
    $runningVMs = & $vmrun list   # The & (call operator) ensures vmrun list runs as an external command
    return $runningVMs -match [regex]::Escape($vmxPath) # Return true if VM's are already running. Regular expressions (regex) use special characters (like . \ * + ? | etc.) to define patterns. If a string contains these characters and you use it directly in a regex match, it may behave unexpectedly. The [regex]::Escape() method is used in PowerShell (and .NET) to safely escape special characters in a string, ensuring that they are treated as literal characters in a regular expression.
}

# Loop through each VM and start it if not already running
foreach ($vm in $vmList) {
    if (test-VMRunning -vmxPath $vm) { # if the function "test-VMRunning" returns true, then it outputs "Vm already running". -vmxPath is the parameter and intakes the list of paths specified in $vmlist
        Write-Host "VM already running: $vm" -ForegroundColor Green
    } else {
        Write-Host "Starting VM: $vm" -ForegroundColor Yellow
        & $vmrun start "$vm"
    }
}

Write-Host "All VMs checked and started if necessary." -ForegroundColor Cyan
