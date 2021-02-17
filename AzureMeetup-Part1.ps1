# Script created by Gísli Guðmundsson
# For Azug Meetup Iceland - 19.02.2021


# Sets Powershell Console as RemoteSigned
if((Get-ExecutionPolicy) -ne "RemoteSigned"){
    Set-ExecutionPolicy RemoteSigned
}

# Installs Azure Module
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    if((Get-Command | Sort-Object -Property Noun | Select-Object Source | Sort-Object -Property Source -Unique | ? { $_.Source -like "Az.*" }) -eq $null){
        Install-Module -Name Az -AllowClobber -Scope CurrentUser
    }
}

# Checks if Module Az.Accounts is imported, else import it
if((Get-Module Az.Accounts) -eq $null){
    Import-Module Az.Accounts
}

# Check if user is logged on, if not then create a connection
if((Get-AzAccessToken -ErrorAction SilentlyContinue) -eq $null){
    Connect-AzAccount
}

# Create a quick search for az commands
function Get-AzCommand($Command){
    Get-Command | Sort-Object -Property Noun | ? { $_.Source -like "Az.*" -and $_.Name -like "*$Command*" } | Format-Table -GroupBy Noun
}
