# Define the path to vmrun.exe
$vmrun = "C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"

# Get a list of running VMs
$listVMs = & $vmrun list

# Skip the first line (it just says "Total running VMs: X")
$runningVMs = $listVMs[1..($listVMs.Length - 1)] # [1..($list.length -1)] is a way to slice through the $listVMs array starting from 1 position to end of array.

# Loop through each VM and attempt to stop it gracefully
foreach ($vm in $runningVMs) {
    Write-Host "Stopping VM: $vm" -ForegroundColor Yellow
    & $vmrun stop "$vm" soft
}

Write-Host "All VMs have been gracefully shutdown." -ForegroundColor Cyan
