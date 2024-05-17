# This function clears all event logs on the specified computer.
# It must be run with administrator privileges.

function clear-all-event-logs {
    param (
        [string]$computerName = "localhost"
    )

    # Get all event logs using Get-WinEvent
    $logs = Get-WinEvent -ListLog * -ComputerName $computerName | ForEach-Object { $_.LogName }
    
    # Clear all event logs using wevtutil
    $logs | ForEach-Object { 
        Write-Output "Clearing log: $_"
        wevtutil cl $_
    }

    # List all event logs to confirm they are cleared
    Get-WinEvent -ListLog * -ComputerName $computerName
}

# Call the function with the current computer name
clear-all-event-logs -ComputerName $env:COMPUTERNAME

# Note: This script must be run as an administrator.
# To run the script as an administrator, open PowerShell with elevated privileges:
# 1. Press Windows Key, type "PowerShell".
# 2. Right-click Windows PowerShell and select "Run as administrator".