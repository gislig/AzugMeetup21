# Script created by Gí­sli Guðmundsson
# For Azug Meetup Iceland - 19.02.2021

Import-Module Az.Compute

# Get all Azure VMs
Get-AzVM

# Start Azure VMs
Start-AzVm -Name AzugMeetupServer -ResourceGroupName AZUGMEETUP

# Launch RDP access
Get-AzRemoteDesktopFile -ResourceGroupName AzugMeetup -Name AzugMeetupServer -Launch